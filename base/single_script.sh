#!/usr/bin/env bash
# add java resources to apt
apt-get update -y && \
    apt-get install -y software-properties-common wget &&\
    add-apt-repository -y ppa:webupd8team/java &&\
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections &&\


# Add a Repository Key for cloudera
wget http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key -O archive.key
sudo apt-key add archive.key

# Set up space for configuration files
mkdir -p /etc/hadoop/cluster-conf
update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/cluster-conf 50
update-alternatives --set hadoop-conf /etc/hadoop/cluster-conf


# perform one apt-get install and one apt-get update
# after adding all required repos
apt-get -y update
apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default \
     hadoop-client openssh-server openssh-client
update-java-alternatives -s java-8-oracle

# for running sshd in ubuntu trusty. https://github.com/docker/docker/issues/5704
mkdir /var/run/sshd
echo 'root:secretpasswd' | chpasswd
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# passwordless ssh
yes | ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
yes | ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
yes | ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# SSH login fix. Otherwise user is kicked off after login
# sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# /usr/sbin/sshd &

# fix the 254 error code
sed  -i "/^[^#]*UsePAM/ s/.*/#&/"  /etc/ssh/sshd_config
echo "UsePAM no" >> /etc/ssh/sshd_config
echo "Port 2122" >> /etc/ssh/sshd_config
/usr/sbin/sshd &

# ssh client config

chmod 600 /root/.ssh/config
chown root:root /root/.ssh/config


chmod 755 /etc/init.d/daemon
chown root:root /etc/init.d/daemon

#perform cleanup to reduce base image size
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/*
find /var | grep '\.log$' | xargs rm -v
