#!/bin/bash

# On development branch

# Creating list of files to log
cd $1
find ./ -type f \( -iname \*.R -o -iname \*.py -o -iname \*.do \) | sed "s/\.\// /g" >> ../filesToLog.txt

# Mirroring the directory structure of the folder containing code
for i in */
do
    if [[ $i != *"archive"* ]]; then
        find $i -type d -exec mkdir -p ../logs/{} \;
    fi
done
cd ../
mv ./filesToLog.txt ./logs/

# Sourcing files
echo -e "\n\033[32mSourcing Files ...\033[39m\n"
cat ./logs/filesToLog.txt | while read i; do
    if [[ $i == *".R" ]]; then
        today=$(date +"%Y-%m-%d-%H%M")
        fileName=$(echo "./logs/$i" | sed "s/\.R/_$today\.txt/")
        Rscript $1/$i >& $fileName
        echo "Logged $i"
    elif [[ $i == *".py" ]]; then
        today=$(date +"%Y-%m-%d-%H%M")
        fileName=$(echo "./logs/$i" | sed "s/\.py/_$today\.txt/")
        python.exe $1/$i >& $fileName
        echo "Logged $i"
    elif [[ $i == *".do" ]]; then
        today=$(date +"%Y-%m-%d-%H%M")
        fileName=$(echo "./logs/$i" | sed "s/\.do/_$today\.txt/")
        stata -e do $1/$i
        cat $(echo $i | sed "s/\.do/\.log/" | sed "s@.*/@@") >& $fileName
        rm *.log
        echo "Logged $i"
    fi
done

# Cleaning up
echo -e "\n\033[32mFinished Logging\033[39m"
rm ./logs/filesToLog.txt
