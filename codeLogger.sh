#!/usr/bin/bash

# Mirroring the directory structure of the folder containing code
cd $1
for i in */
do
    if [[ $i != *"archive"* ]]; then
        find $i -type d -exec mkdir -p ../logs_test/{} \;
        find $i -type f \( -iname \*.R -o -iname \*.py \) >> ../logs_test/filesToLog.txt
    fi
done
cd ../

# Sourcing files
echo -e "\n\033[32mSourcing Files ...\033[39m\n"
cat ./logs_test/filesToLog.txt | while read i; do
    if [[ $i == *".R" ]]; then
        today=$(date +"%Y-%m-%d-%H%M")
        fileName=$(echo ".logs_test/$i" | sed "s/\.R/_$today\.txt/")
        Rscript $1/$i >& $fileName
        echo "Logged $i"
    elif [[ $i == *".py" ]]; then
        today=$(date +"%Y-%m-%d-%H%M")
        fileName=$(echo ".logs_test/$i" | sed "s/\.R/_$today\.txt/")
        python.exe $1/$i >& $fileName
        echo "Logged $i"
    fi
done

# Cleaning up
echo -e "\n\033[32mFinished Logging\033[39m"
rm ./logs_test/filesToLog.txt
