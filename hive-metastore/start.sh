#!/bin/bash
set -x
service mysql start

# restart ssh daemon
/usr/sbin/sshd &

# Wait for DFS to come out of safe mode
until hdfs dfsadmin -safemode wait
do
    echo "Waiting for HDFS safemode to turn off"
    
    
done

/usr/lib/hive/bin/schematool -dbType mysql -initSchema

service hive-metastore start
/etc/init.d/daemon hive-metastore &

tail -f `find /var/log -name *.log -or -name *.out`
