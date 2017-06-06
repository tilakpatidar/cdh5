#!/bin/bash
set -x

# restart ssh daemon
/usr/sbin/sshd &

service zookeeper-server start
/etc/init.d/daemon zookeeper-server &

tail -f `find /var/log -name *.log -or -name *.out`
