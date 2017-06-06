# Adds Cloudera's repositories for Ubuntu Trusty

FROM ubuntu:trusty
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Add the CDH 5 repository
COPY files/cloudera.list /etc/apt/sources.list.d/cloudera.list
# Set preference for cloudera packages
COPY files/cloudera.pref /etc/apt/preferences.d/cloudera.pref
# Add repository for python installation
COPY files/python.list /etc/apt/sources.list.d/python.list

ADD files/ssh_config /root/.ssh/config
ADD files/daemon.sh /etc/init.d/daemon

# add hive conf in base
ADD files/hive-site.xml /etc/hive/conf/hive-site.xml

# run single script to reduce image size
ADD single_script.sh /single_script.sh
RUN chmod 755 /single_script.sh
RUN chown root:root /single_script.sh
RUN /single_script.sh

EXPOSE 22
