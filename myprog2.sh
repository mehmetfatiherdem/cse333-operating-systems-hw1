#!/bin/bash

## check if the arg exists and is a valid file name with a txt extension if not exit the program
if [ $# -ne 1 ] || [  "${1%.txt}" == "$1" ]
then
	echo "$0 : You must give/supply 1 file name with a txt extension"
exit 1
fi


## non-empty lines array
lines=(1 3 5) ## in the given txt files we have line 1, 3 and 5 as non-empty lines so I store them in this array

## Here, we generate 3 random lines from the lines array
randomLine1=${lines[$(($RANDOM % ${#lines[@]}))]}
randomLine2=${lines[$(($RANDOM % ${#lines[@]}))]}
randomLine3=${lines[$(($RANDOM % ${#lines[@]}))]}


## check if the file exists
if [ -e $1 ] 
then
  		
	while [ 1 ]
	do
		echo -n "$1 exists. Do you want it to be modified? (y/n):"
		read answer
	
		if [ $answer = "Y" -o $answer = "y" ]
  		then	
  	 		break
  	 		
  		elif	[ $answer = "N" -o $answer = "n" ]
  		then
  			exit 1
  		else
  			echo "please enter either y/n"
  			continue
  		fi		

		
	done
fi

sed -n ''"$randomLine1"','"$((randomLine1+1))"'p' giris.txt > $1 ## overrides
sed -n ''"$randomLine2"','"$((randomLine2+1))"'p' gelisme.txt >> $1
sed -n ''"$randomLine3"','"$((randomLine3+1))"'p' sonuc.txt >> $1
 		
echo "A random story is created and stored in $1."

