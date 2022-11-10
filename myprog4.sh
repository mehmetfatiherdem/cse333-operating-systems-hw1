#!/bin/bash
rem=0
hexnumbers="0123456789ABCDEF"

lowerBound=2
upperBound=$1
numberOfArgument=$#


# This statement checks invalid input
if [ -z "$upperBound" ] || [[ $upperBound =~ ["a"-"z"] ]] || [[ $numberOfArgument -gt 1 ]] || [[ $upperBound -lt 3 ]];
then
    echo "You must enter exactly 1 argument which must be an integer greater than 2 for the upper bound value"
    exit
fi

# This loop tries to find out every prime number in the given range. If it can find a prime number, it will print the hexadecimal of the prime number
for ((i=$lowerBound; i< $upperBound; i++))
  do
  flag=1
  #This loop checks if the entered number is divisible. If it is not divisible, it is a prime number.
  for ((j=2; j<=$i/2; ++j))
  do
   modulo=$((i%j))
   if [ $modulo -eq 0 ]
   then
     flag=0
   fi
  done  
  #This statement converts decimal prime number to hexadecimal number
  if [ $flag -eq 1 ]
   then 
     decimal=$i
     hex=""
     hexletter=""
     while [ $decimal -gt 0 ]
     do 
         rem=$((decimal%16))
         hexletter=${hexnumbers:$rem:1}
         hex+=$hexletter
         decimal=$((decimal/16))
     done
     strlen=${#hex}
     revstr=""
     for (( a=$strlen-1; a>=0; a-- ))
     do 
         revstr=$revstr${hex:$a:1}
     done
     echo "Hexadecimal of $i is $revstr"
     
   fi 
done