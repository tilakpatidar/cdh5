# Adds a resource manager

FROM local/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

RUN apt-get update && apt-get install -y hadoop-yarn-resourcemanager

# Refer to yarn-site.xml
# RUN mkdir -p /var/lib/hadoop-hdfs/cache/hdfs/dfs/name
# RUN chown -R hdfs:hdfs /var/lib/hadoop-hdfs/cache/hdfs/dfs/name

# exposed ports in sequence
# yarn.resourcemanager.address
# yarn.resourcemanager.scheduler.address
# yarn.resourcemanager.resource-tracker.address
# yarn.resourcemanager.admin.address
# yarn.resourcemanager.webapp.address
# yarn.resourcemanager.webapp.https.address
EXPOSE 8032 8030 8031 8033 8088 8090

EXPOSE 22

USER root
COPY start.sh /opt/hadoop-docker/
CMD ["/opt/hadoop-docker/start.sh"]

#perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*&&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -v
