#!/bin/bash
touch ip.txt
strlen_com=`echo -n $2 | wc -m`
while IFS= read -r line
do
    fe=`echo $line | tr -d '\r' | tr -d '\n'`
    STRLENGTH=`echo -n $fe | wc -m`
    num=${fe: 0:$STRLENGTH}
done < "$1"