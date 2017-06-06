# Adds a ZooKeeper server

FROM local/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

RUN apt-get update && apt-get install -y zookeeper-server

# ZooKeeper (default) data directory
RUN mkdir -p /var/lib/zookeeper &&\
    chown -R zookeeper /var/lib/zookeeper/ &&\
    # ZooKeeper needs to be initialized &&\
    service zookeeper-server init

EXPOSE 2181 22

COPY start.sh /opt/zookeeper/
CMD ["/opt/zookeeper/start.sh"]

#perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*&&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -v