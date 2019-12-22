#!/bin/sh
COUNT=0
for FILE in $1/*.$2
do 
    COUNT=`expr $COUNT + 1`
done
echo $COUNT