#!/bin/bash

echo ">INFILE" >> INFILE.fasta

W2=($(wc -l retained.txt))

x=1
while [ $x -le $W2 ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p retained.txt"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)

if awk -v var=${c1} '$2==var' INFILE | grep -qFw "${c1}"; then

    if awk -v var=${c1} '$2==var' INFILE | grep -Fw "${c1}" | awk '{print $5}' | grep -qFw "." ; then
        awk -v var=${c1} '$2==var' INFILE | grep -Fw "${c1}" | awk '{print $4}' >> INFILE.seq
    else    
        awk -v var=${c1} '$2==var' INFILE | grep -Fw "${c1}" | awk '{print $5}' >> INFILE.seq
    fi
        
else
        echo "N" >> INFILE.seq
fi

x=$(( $x + 1 ))
done

tr --delete '\n' < INFILE.seq >> INFILE.fasta
