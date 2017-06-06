# A cluster node has a datanode, a nodemanager and mapreduce.

FROM local/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

RUN apt-get update && apt-get install -y \
    hue \
    hue-beeswax \
    hue-common \
    hue-doc \
    hue-hbase \
    hue-impala \
    hue-pig \
    hue-plugins \
    hue-rdbms \
    hue-search \
    hue-security \
    hue-server \
    hue-spark \
    hue-sqoop \
    hue-zookeeper

# Hue Server and sshd ports exposed
EXPOSE 8888 22

USER root
COPY start.sh /opt/hadoop-docker/
CMD ["/opt/hadoop-docker/start.sh"]

#perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*&&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -v
