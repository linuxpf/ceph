#!/bin/bash
log=/var/log/ceph/check_cephhealth.log
#[ ! -f $log ] && touch $log
host=`uname -n`
#three args
alarm_prog='/usr/local/monitor-base/bin/alarm.sh'
ceph health detail > $log
if fgrep -q  'HEALTH_OK'  $log; then
echo 'HEALTH_OK'
else
echo 'plase check ceph cluster HEALTH'
#sedn mail
$alarm_prog 'Important ceph cluster HEALTH alarm' "`cat $log|head -n 1000`"  "$host"
fi

