#!/bin/bash

echo -e "Sample\tHeterozygosity" > Heterozygosity.txt

x=1
while [ $x -le 48 ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p files"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
        c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

echo "${c1}" > temp1
grep -F --file=all-contigs.${c1}_200.filtered.txt Weights.txt > ${c1}.polyWeighted.txt # Use the file with ALL of the contigs sequenced for the individual to search within the file containing contig names and weights
awk '{ total += $2 } END { print total/NR }' ${c1}.polyWeighted.txt > temp2
paste temp* >> Heterozygosity.txt
rm temp* ${c1}.polyWeighted*

x=$(( $x + 1 ))

done

