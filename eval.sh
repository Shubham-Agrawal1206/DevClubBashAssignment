#!/bin/bash
COUNTER=0
while IFS= read -r line
do
    echo $line
done < "$1"