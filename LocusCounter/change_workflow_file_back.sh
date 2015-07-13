#!/bin/bash
#Change the hash depending on what you want to do (change workflow.sh back to ThisFile when you're done!)
#sed -i "s/INFILE/$1/g" workflow2.sh #Change the workflow.sh file to read the file you want it to read
sed -i "s/$1/INFILE/g" workflow2.sh # Change it back. 
