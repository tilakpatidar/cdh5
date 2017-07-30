# Adds hdfs client libraries

FROM tilakpatidar/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

RUN apt-get update && apt-get install -y hadoop-client

USER hdfs

EXPOSE 22

ENTRYPOINT ["hdfs"]

USER root
#perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -fv
