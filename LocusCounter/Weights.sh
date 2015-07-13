#!/bin/bash
x=1
while [ $x -le 53257 ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p Weights1.txt"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
        c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

if grep -qFx ${c1} poly-contigs.INFILE_200.filtered.txt ; then
 echo -e "${c1}\t${c2}" >> INFILE_polyweighted.txt
else
 echo "Nope! ${c1} does not occur in sample INFILE, friend"
fi

x=$(( $x + 1 ))

done
