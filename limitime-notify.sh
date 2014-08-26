#!/bin/bash

nth_or() {
    local i
    local line
    local jobdone
    i=$1
    jobdone=0
    while [ "$i" != 1 ]
    do
        if read line
        then
            i=$(($i-1))
        else
            i=1
            echo $2
            jobdone=1
        fi
    done
    if [ $jobdone = 0 ]
    then
        if read line
        then
            echo $line
        else
            echo $2
        fi
    fi
}

critical=$1
if [ -z "$critical" ]
then
    critical=5
fi
username=$(whoami)
while true
do
    consumed=$(cat consumed/$username)
    weekday=$(date +%u)
    allowed=$(cat limits/$username|nth_or $weekday 9999) # 9999 is infinity
    remaining=$(($allowed - $consumed))
    if [ $(($remaining < $critical)) = 1 ]
    then
        notify-send "Remaining $remaining minutes"
    fi
    sleep 60
done
