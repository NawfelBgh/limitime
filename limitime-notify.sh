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

username=$(whoami)
while true
do
    consumed=$(cat consumed/$username)
    weekday=$(date +%u)
    allowed=$(cat limits/$username|nth_or $weekday 0)
    remaining=$(($allowed - $consumed))
    if [ $(($remaining < 5)) = 1 ]
    then
        notify-send "remaining $remaining minutes"
    fi
    sleep 60
done
