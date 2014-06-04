#!/bin/bash
# Write by: weihoop
# Last Modify:2014-05-13
# This script use to install goaccess for centos.

yum -y install glib2 glib2-devel ncurses ncurses-devel GeoIP GeoIP-devel

# centos 5.x install Geoip package
#rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/x86_64/GeoIP-1.4.8-1.el5.x86_64.rpm
#rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/x86_64/GeoIP-devel-1.4.8-1.el5.x86_64.rpm

# centos 6.x install Geoip package
#rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/GeoIP-1.4.8-1.el6.x86_64.rpm
#rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/GeoIP-devel-1.4.8-1.el6.x86_64.rpm

# install goaccess
cd /usr/local/src/
wget http://jaist.dl.sourceforge.net/project/goaccess/0.7.1/goaccess-0.7.1.tar.gz
tar zxf goaccess-0.7.1.tar.gz
cd goaccess-0.7.1
./configure --enable-geoip --enable-utf8
make && make install
