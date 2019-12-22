#!/bin/bash
strlen_com=`echo -n $2 | wc -m`
while IFS= read -r line
count=4
do
    fe=`echo $line | tr -d '\r' | tr -d '\n'`
    if [ ${fe:0:$strlen_com} = $2 ]
    then
    str=`echo $fe | tr ":" " "`
    set -- $str
    re=`expr $# - 2`
    a=( $str )
    string=""
    while [ $count -lt $re ]
    do
    string="$string ${a[$count]}"
    count=`expr $count + 1`
    done
    echo $string
    exit 0
    fi
done < "$1"