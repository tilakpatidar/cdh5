FROM local/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

WORKDIR /data
ADD gobblin-distribution-0.10.0.tar.gz .
RUN mv gobblin-dist gobblin
 
USER root
COPY start.sh /opt/hadoop-docker/
CMD ["/opt/hadoop-docker/start.sh"]
