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
crontab -l | grep -v limitime-line | crontab -
