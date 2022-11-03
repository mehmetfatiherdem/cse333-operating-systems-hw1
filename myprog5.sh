#!/bin/bash

no_argument=100
non_existing_directory=101
no_files_found=148

#These are the possible exit codes of this script, (300 is not a failure but it is informative)

usage="Usage : $0 [Wildcard] [Directory](Optional)";
#This string is printed whenever user uses the script wrongfully

dir="./"

if [ $# -eq 0 ]
then
    #No arguments passed
    echo $usage
    exit $no_argument
elif [ $# -eq 2 ]
then
    #Two arguments passed, so we change the directory from current directory to the one user passed
    dir=$2
elif [ $# -gt 2 ]
then
    #More than two arguments passed
    #No need to exit here since extra arguments do no harm as long as the first two are valid
    echo $usage
fi

if [ ! -e $dir ]
then
    #The directory that user passed does not exist
    echo "The directory does not exist"
    exit $non_existing_directory
fi

tempFile="filespaths.txt"

#Two state variables to print the statistics to the user later on
filesFound=0
filesDeleted=0

#A temporary file to store the matching results of the wildcard
touch $tempFile

#This is used to get rid of the temporary file in case the user kills the program mid-run
trap 'rm $tempFile' EXIT

#Find all the files in the specified directory that match with the wildcard
#In case current directory is specified and the tempFile is a match for the wildcard, it's name is excluded with '! -name "$tempFile"'
find $dir -type f \( -name "$1" -and ! -name "$tempFile" \) > $tempFile

#This function asks the user if the file passed to first argument should be deleted or not, in case of invalid input it keeps asking
ask_delete ()
{
    if [ -n $1 ]
    then
        ans=""

        while true
        do
            echo -n "Do you want to delete $1? (y/n): ";
            #'/dev/tty' is a special file representing the terminal for the current process
            #The reason that's used here is because 'read' expected the input from a file after inputting it from the $tempFile
            #in the while loop, so I had to specify that the input should be taken from the keyboard with the help of this file
            read ans </dev/tty

            if [[ ! $ans =~ [yYnN] ]]
            then
                #Empty or invalid response
                echo "Invalid Response : Type 'y' or 'Y' for yes and 'n' or 'N' for no!"
                continue
            fi
            
            #When a valid response is given
            break
        done

        if [[ $ans =~ [yY] ]]
        then
            #Return 0 when the answer is yes
            return 0
        fi

        #Return 1 when the answer is no
        return 1
    fi

    #Return 2 when the argument is null
    return 2
}

while read line
do
    filesFound=$((filesFound+1))
    ask_delete $line

    if [ $? -eq 0 ]
    then
        #If the answer is yes
        filesDeleted=$((filesDeleted+1))
        rm $line
        echo "1 File Deleted"
    fi
done < $tempFile

if [ $filesFound -eq 0 ]
then
    #Informing the user that no files are found
    echo "No Files found"
    exit $no_files_found
fi

#Printing the statistics
echo "$filesDeleted files deleted out of $filesFound files"
exit 0