# Runs a MapReduce History Server and a YARN proxy server

FROM tilakpatidar/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

# Cloudera says install both of these one "one host". We're not going to use
# the yarn proxy server just yet.
RUN apt-get update && apt-get install -y \
    hadoop-mapreduce-historyserver \
    hadoop-yarn-proxyserver

# ports exposed in sequence
# mapreduce.jobhistory.address
# mapreduce.jobhistory.admin.address
# mapreduce.jobhistory.webapp.address
# mapreduce.jobhistory.webapp.https.address
# sshd port

EXPOSE 10020 10033 19888 19890 22

USER root
COPY start.sh /opt/hadoop-docker/
CMD ["/opt/hadoop-docker/start.sh"]

#perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -v
