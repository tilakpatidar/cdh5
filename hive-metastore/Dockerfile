# A cluster node has a datanode, a nodemanager and mapreduce.

FROM local/ubuntu-cdh5-base
MAINTAINER Tilak Patidar tilakpatidar@gmail.com

# using mysql for metastore
# using postgres as source db for our importers
# TODO: different dbs? getting issues with postgres on metastore, resolve later

RUN apt-get update &&\
    apt-get install -y hive hive-metastore libmysql-java &&\
    ln -s /usr/share/java/mysql-connector-java.jar /usr/lib/hive/lib/mysql-connector-java.jar

# Install MySQL.
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server &&\
  rm -rf /var/lib/apt/lists/* && \
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
  sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/my.cnf && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'CREATE DATABASE metastore;'" >> /tmp/config &&\
  echo "mysql -e 'CREATE USER hive@localhost IDENTIFIED BY \"elephants\";'" >> /tmp/config &&\
  echo "mysql -e 'GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'localhost';'" >> /tmp/config &&\
  echo "mysql -e 'FLUSH PRIVILEGES;'"  >> /tmp/config &&\
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config

# copy migrations
ADD ./hive_migrations /usr/lib/hive/hive_migrations

# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql"]

# Define working directory.
WORKDIR /data

# Exposed ports in sequence.
# MySQL port
# Hive Metastore port
# sshd

EXPOSE 3306 9083 22

ADD start.sh /opt/hadoop-docker/start.sh
CMD ["/opt/hadoop-docker/start.sh"]

#perform cleanup to reduce base image size
RUN apt-get autoremove -y &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*&&\
    rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/* &&\
    find /var | grep '\.log$' | xargs rm -v
