#!/bin/bash

no_argument=200
non_existing_directory=201

usage="Usage : $0 [Wildcard] [Directory](Optional)";
dir="./"


if [ $# -eq 0 ]
then
    echo $usage
    exit $no_argument
elif [ $# -eq 2 ]
then
    dir=$2
elif [ $# -gt 2 ]
then
    echo $usage
    #No need to exit here since extra arguments do no harm as long as the first two are valid
fi

if [ ! -e $dir ]
then
    echo "The directory does not exist"
    exit $non_existing_directory
fi

ask_delete ()
{
    if [ -n $1 ]
    then
        ans=""

        while [[ ! $ans =~ [yYnN] ]]
        do
            echo -n "Do you want to delete $line? (y/n): ";
            read ans </dev/tty
            #echo ""
        done

        if [[ $ans =~ [yY] ]]
        then
            rm $1
            echo "1 File Deleted"
        fi
    fi

    return 0
}

filename="filespaths.txt"
filesFound=0
touch $filename
trap 'rm $filename' EXIT
find $dir -type f \( -name "$1" -and ! -name "$filename" \) > $filename

while read line
do
    filesFound=$((filesFound+1))
    ask_delete $line
done < $filename

if [ $filesFound -eq 0 ]
then
    echo "No Files found"
fi