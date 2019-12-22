#!/bin/bash
COUNTER=0
while IFS= read -r line
do
    fe=`echo $line | tr -d '\r' | tr -d '\n'`
    op=${fe: -1}
    STRLENGTH2=`echo -n $op | wc -m`
    if [ $STRLENGTH2 != 1 ]
    then
    STRLENGTH=`echo -n $fe | wc -m`
    STRLENGTH=`expr $STRLENGTH - $STRLENGTH2`
    STRLENGTH=`expr $STRLENGTH - 1`
    num=${fe: 0:$STRLENGTH}
    COUNTER=`expr $COUNTER \* $num`
    continue
    fi
    STRLENGTH=`echo -n $fe | wc -m`
    STRLENGTH=`expr $STRLENGTH - $STRLENGTH2`
    STRLENGTH=`expr $STRLENGTH - 1`
    num=${fe: 0:$STRLENGTH}
    COUNTER=`expr $COUNTER $op $num`
done < "$1"
echo $COUNTER