#!/bin/bash
rem=0
hexnumbers="0123456789ABCDEF"

lowerBound=2
upperBound=$1
numberOfArgument=$#



if [ -z "$upperBound" ] || [[ $upperBound =~ ["a"-"z"] ]] || [[ $numberOfArgument -gt 1 ]] || [[ $upperBound -lt 3 ]];
then
    echo "You must enter exactly 1 argument which must be an integer greater than 2 for the upper bound value"
    exit
fi

for ((i=$lowerBound; i< $upperBound; i++))
  do
  flag=1
  for ((j=2; j<=$i/2; ++j))
  do
   modulo=$((i%j))
   
  
  
   if [ $modulo -eq 0 ]
   then
     flag=0
   fi
  done  

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