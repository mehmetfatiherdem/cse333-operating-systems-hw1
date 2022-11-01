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

filename="filepaths.txt"
touch $filename

find $dir -type f \( -name "$1" -and ! -name "$filename" \)

rm $filename
