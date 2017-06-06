#!/usr/bin/env bash

function build_base_image(){
    echo "[INFO] Building base image for cluster"
    (cd base && ./build.sh) || (echo "[ERROR] build base image failed" && exit 1)
    echo "[INFO] Built base image for cluster"
}
function build_service_images(){
    echo "[INFO] Building service images for cluster"
    (docker-compose build &&\
        echo "[INFO] Built service images for cluster"
    ) || ( echo "[ERROR] build service images failed" && exit 1)
}

function build_images(){
    build_base_image
    build_service_images
}
function create_network_config(){
    echo "[INFO] Creating docker network $DOCKER_MACHINE_NAME-local"
    (docker network create -d bridge \
  --subnet=172.20.0.0/16 --gateway 172.20.0.1 --ip-range=172.20.0.0/16 \
  $DOCKER_MACHINE_NAME-local)

    echo "[INFO] Create /etc/resolver setup for dns"
    export DOCKER_HOST_IP=$(docker-machine ip $DOCKER_MACHINE_NAME)
    sudo rm -rf /etc/resolver/$DOCKER_MACHINE_NAME-local
    sudo mkdir /etc/resolver
    echo "nameserver $DOCKER_HOST_IP" | sudo tee /etc/resolver/$DOCKER_MACHINE_NAME-local
    sudo route -n add -net 172.20.0.0 $DOCKER_HOST_IP
}

function remove_network_config(){
    echo "[INFO] Removing old network config"
    # remove old networking settings if exists
    sudo rm /etc/resolver/$DOCKER_MACHINE_NAME-local
    sudo route -n delete 172.20.0.0
}
function create_docker_machine(){
    (docker-machine create --driver=virtualbox --virtualbox-memory $VIRTUALBOX_MEMORY  $DOCKER_MACHINE_NAME &&\
    echo "[INFO] Docker machine created")
}
function start_services(){
    (docker-compose up) &
    (docker-compose scale clusternode=$CLUSTER_NODES)
}

function clean_up(){
     echo "[INFO] Remove old orphan volumes"
     (docker-compose down --remove-orphans && docker volume rm $(docker volume ls -f dangling=true -q))
}

function start_docker_machine(){
     echo "[INFO] Start docker machine $DOCKER_MACHINE_NAME"
     docker-machine start $DOCKER_MACHINE_NAME
     eval $(docker-machine env $DOCKER_MACHINE_NAME)
}






########################## Main Script ########################################
# start main script

eval "$(docker-machine env -u)" # reset docker machine env
DOCKER_MACHINE_NAME=cdh5
CLUSTER_NODES=$1
VIRTUALBOX_MEMORY=8000

[ -z "$CLUSTER_NODES" ] &&  CLUSTER_NODES=1


echo "[INFO] Make all scripts executable"
# make all scripts executable
find ./ -name "*.sh" -exec chmod +x {} \;

echo "[INFO] DOCKER_MACHINE_NAME=$DOCKER_MACHINE_NAME CLUSTER_NODES=$CLUSTER_NODES VIRTUALBOX_MEMORY=$VIRTUALBOX_MEMORY"
echo "[INFO] Starting cluster with nodes: $CLUSTER_NODES"

docker_machine_name=$(docker-machine ls | grep "^$DOCKER_MACHINE_NAME$" )

if [ ${#docker_machine_name} -ge 1 ]; then
     echo "[INFO] Docker machine already exists booting up"

else
     echo "[INFO] Docker machine does not exists creating it first"
     create_docker_machine
fi
     start_docker_machine
     remove_network_config
     create_network_config
     build_images
     start_services $1
