#!/bin/bash
set -x
# restart ssh daemon
/usr/sbin/sshd &

# Wait for DFS to come out of safe mode
until hdfs dfsadmin -safemode wait
do
    echo "Waiting for HDFS safemode to turn off"
    # force safemode leave
    hdfs dfsadmin -safemode leave
done

service kafka-server start

tail -f `find /var/log -name *.log -or -name *.out`
