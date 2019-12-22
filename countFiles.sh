#!/bin/sh
COUNT=0
if [ $2 ]
then
for FILE in $1/*.$2
do 
    COUNT=`expr $COUNT + 1`
    if [ ! -e $FILE ]
    then
    COUNT=0 
    echo $COUNT
    exit 1
    fi
done
else
for FILE in $1/*
do 
    COUNT=`expr $COUNT + 1`
    if [ ! -e $FILE ]
    then
    COUNT=0 
    echo $COUNT
    exit 1
    fi
done
fi
echo $COUNT