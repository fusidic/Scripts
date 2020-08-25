#!/bin/bash
# Author:	Fusidic
# Date:		2020-06-22

flag=0
while true; do
    random=$(((RANDOM % 10) + 5))
    echo "下次变更 $random 秒以后"
    flag=$[($flag+1)%2]
    echo $flag
    sleep $random
    if [ $flag -eq 0 ]; 
    then 
        bash ./blockBadAss.sh drop
    else
        bash ./blockBadAss.sh pass
    fi
done