#!/bin/bash
cat >/tmp/hostname.txt <<EOF
0.0.0.0 github.com
EOF

cat /tmp/hostname.txt |while read line
do
    echo $line
    IP=`echo $line |awk '{print $1}'`
    HOSTNAME=`echo $line |awk '{print $2}'`
    LOCALIP=`ifconfig eth0 |awk '/inet /{print $2}'`

    if [ "$IP" == "$LOCALIP" ];then
        hostnamectl --static set-hostname $HOSTNAME
    fi
done
