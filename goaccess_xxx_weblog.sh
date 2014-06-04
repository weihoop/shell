#!/bin/sh
# Write by: spitfire
# Last Modify:2014-05-14
# This script use for analysis Market weblog
##########################################################
##  1. 使用此脚本修改一下以下带有“xxx”的变量即可        ##
##  2. 生成的html可以提供web访问，可以开启nginx目录浏览 ##
##########################################################
PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/sbin:/usr/sbin:/bin

# 时间为年-月的格式
MONTH=`date +%Y-%m`
DAY=`date +%Y-%m-%d`
YESTERDAY=`date +%Y%m%d --date="yesterday"`
WEBROOT="/data/www/wwwroot/"
WEBLOG_PATH="/data/backup/weblogbackup/www.xxx.com/*/${MONTH}"
TMPFILE="/data/weblogtmp"
DOMAIN="www.xxx.com"

mkdir -p $WEBROOT/$MONTH
mkdir -p $TMPFILE

# 解压3台服务器上的imgaconunt.mygame88的web日志，并使用goaccess进行分析
for WEBLOG_GZIP in `ls  ${WEBLOG_PATH}/${DOMAIN}.${YESTERDAY}.access.log.gz`
do
   SERVERIP=`ls $WEBLOG_GZIP|sed -rn 's/.*[^0-9](([0-9]+\.){3}[0-9]+).*/\1/p'`
   unpigz -c $WEBLOG_GZIP > ${TMPFILE}/${DOMAIN}.${YESTERDAY}.${SERVERIP}.access.log
   cat ${TMPFILE}/${DOMAIN}.${YESTERDAY}.${SERVERIP}.access.log |goaccess -a > ${WEBROOT}/${DOMAIN}.${YESTERDAY}.${SERVERIP}.html
done

# 合并weblog日志,注意，若日志过大，比较消耗内存
#cat ${TMPFILE}/${DOMAIN}.${YESTERDAY}.*.access.log > ${TMPFILE}/${DOMAIN}.${YESTERDAY}.all.access.log

# 分析合并后的weblog日志
#cat ${TMPFILE}/${DOMAIN}.${YESTERDAY}.all.access.log |goaccess -a > ${WEBROOT}/${DOMAIN}.${YESTERDAY}.all.html

# 删除日志
rm -f ${TMPFILE}/${DOMAIN}.*.access.log

# 移动走前3天的分析结果
find $WEBROOT -maxdepth 1 -type f -name "*.html" -mtime 3 |xargs -i mv {} ${WEBROOT}/`date +%Y-%m --date="3 days ago"`
