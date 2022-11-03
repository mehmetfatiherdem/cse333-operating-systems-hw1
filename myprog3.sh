writableDir="writable"

if [ ! -e $writableDir ]
then
    mkdir $writableDir
fi

tempFile="filesPaths"
touch $tempFile

trap 'rm $tempFile' EXIT

fileName=$0;
fileName=${fileName:2}

find . -maxdepth 1 -type f \( ! -name "$tempFile" -and ! -name "$fileName" \)> $tempFile 

permissions=""
filesFound=0

while read path
do
    permissions=$(ls -l $path)
    permissions=${permissions:2:1}

    if test $permissions = "w"
    then
        filesFound=$((filesFound+1))
        mv $path $writableDir
    fi
done < $tempFile

echo "$filesFound files moved to writable directory"
exit 0