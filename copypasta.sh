#!/bin/bash
touch ipp.txt
match="<name"
while IFS= read -r line
do
    fe=`echo $line | tr -d '\r' | tr -d '\n'`
    echo $fe
    bi=${fe:0:5}
    if [ $match = $bi ]
    then
    string="<name val=\"$2\">"
    echo $string >> ipp.txt
    else
    echo $line >> ipp.txt
    fi
done < "$1"
rm input.txt
mv ipp.txt input.txt
