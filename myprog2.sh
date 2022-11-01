#!/bin/bash

## check if the arg exists and is a valid file name with a txt extension if not exit
if [ $# -ne 1 ] || [  "${1%.txt}" == "$1" ]
then
	echo "$0 : You must give/supply 1 file name with a txt extension"
exit 1
fi


## non-empty lines array
lines=(1 3 5)


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
  		
	while [ 1 ]
	do
		echo "$1 exists. Do you want it to be modified? (y/n):"
		read answer
	
		if [ $answer = "Y" -o $answer = "y" ]
  		then
  	 		break
  	 		
  		elif	[ $answer = "N" -o $answer = "n" ]
  		then
  			sed -n ''"$randomLine1"','"$((randomLine1+1))"'p' giris.txt >> $1 ## appends
  			sed -n ''"$randomLine2"','"$((randomLine2+1))"'p' gelisme.txt >> $1
  			sed -n ''"$randomLine3"','"$((randomLine3+1))"'p' sonuc.txt >> $1
  			echo "A random story is created and stored in $1."
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

