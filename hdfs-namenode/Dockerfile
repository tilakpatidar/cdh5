# Adds an HDFS namenode

FROM local/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

RUN apt-get update && apt-get install -y hadoop-hdfs-namenode

# Refer to hdfs-site.xml
RUN mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/dfs/name &&\
    chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/dfs/name

# We need skeleton configs to format the namenode
COPY ["conf.skeleton", "/etc/hadoop/cluster-conf"]

# Before starting the NameNode for the first time you need to format the file system.
RUN service hadoop-hdfs-namenode init

# ports exposed in sequence
# fs.defaultFS
# dfs.namenode.servicerpc-address
# dfs.namenode.http-address (HTTP)
# dfs.namenode.https-address (HTTPS)
# sshd
EXPOSE 8020 8022 50070 50470 22

COPY start.sh /opt/hadoop-docker/
CMD ["/opt/hadoop-docker/start.sh"]

#perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*&&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -v