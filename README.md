# Overview

codeLogger is a bash script that will create a directory, titled 'logs_test', to mirror the directory creating your code, find all R and python files, run them and log their output to a text file in the logs directory. This is useful at the end of a project when you want to immortalize the output or during development as you change upstream code and are interested in identifying all downstream changes.

For example, let's say you have finished constructing your data and doing multiple descriptive analyses on it. However, you realize that you made an error in the data construction. So you fix the error but now have to re-run all of the descriptives to check which values changed and which didn't. Using codeLogger, you can easily compare specific analysis files to quickly and accurately identify which descriptive statistics changed and which didn't.

Note, codeLogger will run ALL the .R and .py files contained within the sub-directory that you point it to. If you wish to only log a single directory within your code directory (such as 01_dataConstruction in the example below) simply provide that directory to codeLogger.

# How to use

codeLogger should be run using your bash terminal of choice (git-bash on windows) from the root of the project directory and given the name of the folder containing your code: `path/to/codeLogger.sh ./code`. If successful, you will find the results in a folder titled 'logs_test' that has a directory structure mirroring that of the one where your code lives. In place of the .R or .py files will be .txt files containing the logs.

codeLogger works best when your analysis files are organized in a sub-directory within the larger project folder. For example:

```
myDataScienceProject
|
|-- data
|-- README
|-- code
    |-- 01_dataConstruction
        |-- 01A_getDataA.R
        |-- 01B_getDataB.R
        |-- 01C_mergeData.R
    |-- 02_descriptiveAnalyses
        |-- 02A_userDescriptives.R
    |-- 03_modeling
        |-- 03A_train.py
    |-- 04_modelEvaluation
    |-- ...
```

# Possible Issues

## 1. Can't find R package

If you are running this on Windows server then there is the possibility that the default Rscript interpreter will throw an error saying: "Error in library([package]) : there is no package called [package]. This is because git-bash is running a different version of R than you use when using Rstudio or R interactively on the command line. The workaround is to point the file directly to your local Rscript.exe. You can find this by running `Rscript -e "print(R.home())"` then hardcode line 20 to point to the Rscript executable such as '/c/Program\ Files/R/R-4.0.1/bin/Rscript.exe'.
