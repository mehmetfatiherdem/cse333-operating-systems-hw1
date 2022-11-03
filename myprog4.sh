#!/bin/bash

lowerBound=2
upperBound=$1
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
     echo "$i"
   fi 
done

echo "code finished"