# A cluster node has a datanode, a nodemanager and mapreduce.

FROM tilakpatidar/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

RUN apt-get update && apt-get install -y \
    hadoop-hdfs-datanode \
    hadoop-mapreduce \
    hadoop-yarn-nodemanager

# Refer to hdfs-site.xml
RUN mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/dfs/data &&\
    chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/dfs/data &&\
    # Refer to yarn-site.xml &&\
    mkdir -p /var/lib/hadoop-yarn/cache/nm-local-dir &&\
    chown -R yarn:yarn /var/lib/hadoop-yarn/cache/nm-local-dir &&\
    mkdir -p /var/log/hadoop-yarn/containers &&\
    chown -R yarn:yarn /var/log/hadoop-yarn/containers

#ports exposed in sequence
# dfs.datanode.address
# dfs.datanode.address (Secure)
# dfs.datanode.http.address
# dfs.datanode.https.address
# dfs.datanode.http.address (Secure)
# dfs.datanode.ipc.address
# mapreduce.shuffle.port (created by the YARN NodeManager?)
# sshd
EXPOSE 50010 1004 50075 50475 1006 50020 13562 22

USER root
COPY start.sh /opt/hadoop-docker/
CMD ["/opt/hadoop-docker/start.sh"]

#perform cleanup to reduce image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*&&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -v
