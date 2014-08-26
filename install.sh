#!/bin/bash

dist=$1
if [ -z "$dist" ]
then 
    dist=/limitime
fi

mkdir $dist
cp limitime.sh $dist/limitime.sh
cp limitime-notify.sh $dist/limitime-notify.sh
cd $dist
chmod 555 limitime.sh
chmod 555 limitime-notify.sh
chown root:root limitime.sh
chown root:root limitime-notify.sh

mkdir limits
mkdir consumed
chown root:admin limits
chown root:admin consumed
chmod 775 limits
chmod 775 consumed
chmod g+s limits
chmod g+s consumed

{ crontab -l; echo "* * * * * cd $dist && ./limitime.sh # limitime-line "; } | crontab -
