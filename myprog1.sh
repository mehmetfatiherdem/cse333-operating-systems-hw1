#!/bin/bash
#
#Script to test while statement
#
#
word=$1
shift=$2
alphabet="abcdefghijklmnoprstuvwxyz"
length=`echo -n $1 | wc -c`
echo "$length"
counter=0
shiftTemp=$shift
decimal=10

#this statement checks if the word (first input) contains number
if [[ $word =~ [0-9] ]]
then  
    echo "Input contains number"
    exit
fi

#this loop calculates how many digits there are in a number (second input) 
while [ $shiftTemp -gt 0 ]
do
   shiftTemp=`expr $shiftTemp / $decimal`
   counter=`expr $counter + 1`
done


#this statement checks if inputs are correct
if [ "$length" -eq "$counter" ] || [ "$counter" -eq 1 ]
then 
    echo "your imputs are correnct"
else
    echo "your inputs are incorrect"
    exit
fi
