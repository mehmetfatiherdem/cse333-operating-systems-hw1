#!/bin/bash

## general input check
if [ $# -eq 0 ]
then
echo "$0 : You must give/supply 1 file name with a txt extension"
exit 1
fi

## non-empty lines array
lines=(1 3 5)

# seed random
RANDOM=$$$(date +%s)


randomLine1=${lines[$(($RANDOM % ${#lines[@]}))]}
randomLine2=${lines[$(($RANDOM % ${#lines[@]}))]}
randomLine3=${lines[$(($RANDOM % ${#lines[@]}))]}

## added for debug purposes remove them before merging
echo "$randomLine1"
echo "$randomLine2"
echo "$randomLine3"

## check if the file exists
if [ -e $1 ] 
then
  echo "$1 exists. Do you want it to be modified? (y/n):"
  read answer
  if [ $answer = "Y" -o $answer = "y" ]
  then
  	 sed -n ''"$randomLine1"','"$((randomLine1+1))"'p' giris.txt > $1
  	 sed -n ''"$randomLine2"','"$((randomLine2+1))"'p' gelisme.txt >> $1
  	 sed -n ''"$randomLine3"','"$((randomLine3+1))"'p' sonuc.txt >> $1
  	
  elif	[ $answer = "N" -o $answer = "n" ]
  then
  	sed -n ''"$randomLine1"','"$((randomLine1+1))"'p' giris.txt >> $1
  	sed -n ''"$randomLine2"','"$((randomLine2+1))"'p' gelisme.txt >> $1
  	sed -n ''"$randomLine3"','"$((randomLine3+1))"'p' sonuc.txt >> $1
  else
  	echo "please enter either y/n"
  fi		
else
  	sed -n ''"$randomLine1"','"$((randomLine1+1))"'p' giris.txt > $1
  	sed -n ''"$randomLine2"','"$((randomLine2+1))"'p' gelisme.txt >> $1
  	sed -n ''"$randomLine3"','"$((randomLine3+1))"'p' sonuc.txt >> $1
fi


