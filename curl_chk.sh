#!/bin/bash
# Modify by weihoop 
# Last Modify: 2014-06-04
# This script is used to check url status. 
for i in `cat domain.txt`
do 
   STATUS_CODE=`curl -o /dev/null -s -w %{http_code} http://${i}/baidu.html`
   echo "$i:\t$STATUS_CODE"
done
