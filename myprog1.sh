#!/bin/bash
#
#Script to test while statement
#
#
word=$1
shift=$2
wordEncrypted=""
alphabet="abcdefghijklmnopqrstuvwxyz"
length=`echo -n $1 | wc -c`
echo "$length"
counter=0
shiftTemp=$shift
decimal=10
one=1

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
    echo "your imputs are correct"
else
    echo "your inputs are incorrect"
    exit
fi



#this statement checks if the shifting number has more than one digit
if [ $counter -eq 1 ];
then

  for ((i=0; i< $length; i++))
  do


   dummyletter=${word:$i:1}
   prefix=${alphabet%%$dummyletter*}
   alphabetindex=${#prefix}
   pos=$(((alphabetindex+shift)%26))
   encryptedletter=${alphabet:$pos:1} 
   wordEncrypted+=$encryptedletter


  done
else


  divider=1
  for ((j=1; j< $counter; j++))
  do
   divider=$((divider*10))
  done


  for ((i=0; i< $length; i++))
  do
   dummyletter=${word:$i:1}
   prefix=${alphabet%%$dummyletter*}
   alphabetindex=${#prefix}
   shiftdigit=$((shift / divider))
   pos=$(((alphabetindex+shiftdigit)%26))
   encryptedletter=${alphabet:$pos:1}
   wordEncrypted+=$encryptedletter
   subsFromShift=$((shiftdigit*divider))
   shift=$((shift-subsFromShift))
   divider=$((divider/10))
   done

fi



echo "$wordEncrypted"
