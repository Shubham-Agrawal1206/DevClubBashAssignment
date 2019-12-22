#!/bin/bash
COUNTER=0
while IFS= read -r line
do
    fe=`echo $line | tr -d '\r' | tr -d '\n'`
    op=${fe: -1}
    STRLENGTH=`echo -n $fe | wc -m`
    STRLENGTH=`expr $STRLENGTH - 2`
    num=${fe: 0:$STRLENGTH}
    COUNTER=`expr $COUNTER $op $num`
    echo $op
done < "$1"
echo $COUNTER