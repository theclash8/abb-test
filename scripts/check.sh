#!/bin/bash

PUBLIC_IP=`curl -s ifconfig.io`
DEFAULT_ROUTE=`/sbin/ip route | awk '/default/ { print $3 }'`
CHECK_CONNECTIVITY=`ping -q -c1 ${DEFAULT_ROUTE} | awk -F'/' 'END{ print (/^rtt/? $5" ms":"FAIL") }' && RET='OK' || RET='KO'`


echo "Your Public IP is: ${PUBLIC_IP}"
echo "Your Default Route is: ${DEFAULT_ROUTE}"
echo "Connectivity with ${DEFAULT_ROUTE}: $RET" 
echo "Ping latency: ${CHECK_CONNECTIVITY}"




 # Writing data to influxdb
 curl -i -XPOST 'http://localhost:8086/write?db=mydb' --data-binary 'ping_latency,value=${CHECK_CONNECTIVITY}'
