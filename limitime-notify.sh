#!/bin/bash

nth_or() { (cat; echo "" )|head -n $1 | tail -n 1 | sed 's/^\s*$/'$2'/'; }

critical=$1
if [ -z "$critical" ]
then
    critical=5
fi
echo critical $critical
username=$(whoami)
echo username $username
while true
do
    consumed=$(cat consumed/$username)
    echo consumed $consumed
    weekday=$(date +%u)
    echo weekday $weekday
    allowed=$(cat limits/$username|nth_or $weekday 9999) # 9999 is infinity
    echo allowed $allowed
    remaining=$(($allowed - $consumed))
    echo remaining $remaining
    if [ $(($remaining <= $critical)) = 1 ]
    then
        notify-send "Remaining $remaining minutes"
    fi
    sleep 60
done
