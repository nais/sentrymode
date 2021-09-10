#!/bin/bash

min_load=$1
interval=$2

if [[ ${#} != 2 ]]; then
  echo "usage: ${0} <min_load> <interval>"
  exit 1
fi

while sleep "${interval}"; do
  load=$(uptime | sed -rne 's|.*load average: ([0-9]+)\..*|\1|p')
  if [[ load -gt min_load ]]; then
	echo "apapapp high load (${load}), snap snap etc..."
    rootdir=/opt/sentrymode
    find $rootdir -type d -ctime 5 | xargs rm -rf # delete old snapshots
    dir=$rootdir/$(date +%Y-%m-%d_%H%M%S)
    mkdir -p "$dir"
    docker ps | awk '{print $2}' | grep -v pause | grep -vE '^[a-z0-9]*$' > "$dir"/docker-ps
    top -b -n 1 > "$dir"/top
  fi
done

