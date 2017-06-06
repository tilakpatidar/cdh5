#!/bin/bash

function start_service_if_not_running {
   dead=$(/etc/init.d/"$1" status | grep -E "dead|not running|killed" )
   echo $dead
   if [ ${#dead} -ge 1 ]; then
      echo "starting $1"
      /etc/init.d/$1 start
   else
     echo "$1 is still running"
   fi
}

echo "Starting $1 daemon"
while true; do start_service_if_not_running $1;sleep 5; done

