#!/bin/bash

LIST="pcs pacemaker fence-agents-all corosync glibc resource-agents clufter"
DOWNLOAD_log=/var/log/repo/download_rpm.log
UPDATE_log=/var/log/repo/create_repo.log
IFILE=/tmp/get_index_file
LINK=http://mirror.centos.org/centos/7.5.1804/os/x86_64/Packages
DIR=/mirror/CentOS-v7/pacemaker/pacemaker-centos-rpms/Packages/

rm -rf $DIR/*.rpm
rm -rf $DIR/*.rpm.*
wget $LINK -O $IFILE
array=()
while read line; do
  array+=( "$line" )
done < <( for i in $LIST; do cat $IFILE | egrep "$i" | cut -d'"' -f 8; done )

for item in "${array[@]}"; do
        wget $LINK/$item -P $DIR >> $DOWNLOAD_log
done

createrepo -v  /mirror/CentOS-v7/pacemaker/pacemaker-centos-rpms -g /var/www/html/key.xml >> $UPDATE_log
