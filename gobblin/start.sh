#!/bin/bash
set -x

# restart ssh daemon
/usr/sbin/sshd &

# use restart because start is giving no pid file exists issue
/data/gobblin/bin/gobblin-standalone.sh restart

sleep 50

tail -f `find /data/gobblin/logs -name *.log -or -name *.out`

