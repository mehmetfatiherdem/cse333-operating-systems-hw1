#!/bin/bash

writableDir="writable"

#Create the writable directory if it does not exist already
if [ ! -e $writableDir ]
then
    mkdir $writableDir
fi

#Create a temporary file
tempFile="filesPaths"
touch $tempFile

#Remove the temporary file in case the user kills the program mid-execution
trap 'rm $tempFile' EXIT

fileName=$0;
#Get the name of the script without './'
fileName=${fileName:2}

#Find all the files in the current directory except the temporary file and the script itself and redirect the output to the temporary file
find . -maxdepth 1 -type f \( ! -name "$tempFile" -and ! -name "$fileName" \)> $tempFile 

permissions=""
filesFound=0

#Read the temporary file line by line
while read path
do
    #List the individual file with long format (which starts with the permission string)
    permissions=$(ls -l $path)
    #Permissions look like this : -rwxrwxrwx , so the write permission of the user will always be at the 2nd index
    #So, after executing this line $permissions variable will hold the value 'w' if the file is writable
    permissions=${permissions:2:1}

    if test $permissions = "w"
    then
        #Move the file to writable directory if it is writable
        filesFound=$((filesFound+1))
        mv $path $writableDir
    fi
done < $tempFile

#Printing statistics
echo "$filesFound files moved to writable directory"
exit 0