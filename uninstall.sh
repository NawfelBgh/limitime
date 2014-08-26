#!/bin/bash

dist=$1
if [ -z "$dist" ]
then 
    dist=/limitime
fi

if [ ! -d $dist ]
then
    exit 1
fi

rm -r $dist
grep limitime-line /var/spool/cron/root -v > /var/spool/cron/root-temp-limitime
mv -f /var/spool/cron/root-temp-limitime /var/spool/cron/root 
