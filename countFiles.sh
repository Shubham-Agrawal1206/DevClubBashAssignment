#!/bin/sh
COUNT=0
if [ $2 ]
then
for FILE in $1/*.$2
do 
    COUNT=`expr $COUNT + 1`
done
else
for FILE in $1/*
do 
    COUNT=`expr $COUNT + 1`
done
fi
echo $COUNT