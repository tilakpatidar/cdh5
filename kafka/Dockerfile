
FROM tilakpatidar/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

RUN apt-get update
RUN apt-get install kafka kafka-server

EXPOSE 9092

ADD start.sh /opt/hadoop-docker/start.sh

CMD ["/opt/hadoop-docker/start.sh"]