# A cluster node has a datanode, a nodemanager and mapreduce.

FROM tilakpatidar/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

RUN apt-get update && apt-get install -y \
    hive-server2 \
    hive-webhcat-server

# ports exposed in sequence
# hive.server2.thrift.port
# templeton.port
# sshd port
EXPOSE 10000 10002 50111 22

USER root
COPY start.sh /opt/hadoop-docker/
CMD ["/opt/hadoop-docker/start.sh"]

#perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*&&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -v
