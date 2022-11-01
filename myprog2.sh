## general input check
if [ $# -eq 0 ]
then
echo "$0 : You must give/supply 1 file name with a txt extension"
exit 1
fi

## check if the file exists
if [ -e $1 ] 
then
  echo "$1 exists. Do you want it to be modified? (y/n):"
  read answer
  if [ $answer = "Y" -o $answer = "y" ]
  then
  	 sed -n '5,6p' giris.txt > $1
  	 sed -n '1,2p' gelisme.txt >> $1
  	 sed -n '3,4p' sonuc.txt >> $1
  	
  elif	[ $answer = "N" -o $answer = "n" ]
  then
  	sed -n '5,6p' giris.txt >> $1
  	sed -n '1,2p' gelisme.txt >> $1
  	sed -n '3,4p' sonuc.txt >> $1
  else
  	echo "please enter either y/n"
  fi		
else
  	sed -n '5,6p' giris.txt > $1
  	sed -n '1,2p' gelisme.txt >> $1
  	sed -n '3,4p' sonuc.txt >> $1
fi


