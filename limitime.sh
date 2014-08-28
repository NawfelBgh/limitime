#!/bin/bash
# this file is executed with root permissions every minute by cron

# so that users who belong to the admin group can change the created files
umask 002

# echo the $1 nth line of stdin
# if that line doesn't exist than echo $2
nth_or() { (cat; echo; )|head -n $1 | tail -n 1 | sed 's/^\s*$/'$2'/'; }

for username in $(ls /home)
do
    if [ -e limits/$username ] && # if a roule is defined for user
        { who | grep '^'$username > /dev/null; } # user is logged on 
    then
        if [ ! -e consumed/$username ] ||
            [ $(( $(date -d $(date +%Y/%m/%d) +%s) >
                  $(stat consumed/$username -c %Y) )) == 1 ] # consumed/$username was not modified today
        then
            echo 0 > consumed/$username
        fi
        weekday=$(date +%u)
        # blank lines are interpreted as INFINITY (there are less than 9999min in a day)
        timepermited=$(cat limits/$username|nth_or $weekday 9999) 
        timeconsumed=$(cat consumed/$username)
        if [ $(($timeconsumed > $timepermited)) = 1 ]
        then
            # exit users session
            pkill -u $username -KILL
        else
            echo $(($timeconsumed+1)) > consumed/$username
        fi
    fi
done
