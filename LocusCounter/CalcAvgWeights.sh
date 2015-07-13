#!/bin/bash
x=1
while [ $x -le 48 ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p files"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
        c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

echo "${c1}" > ${c1}temp1
awk '{ total += $2 } END { print total/NR }' ${c1}_allweighted.txt > ${c1}temp2
paste ${c1}temp1 ${c1}temp2 > ${c1}.AVGweightA.txt 

rm ${c1}temp*

x=$(( $x + 1 ))

done

cat *.AVGweightA.txt > AF_AverageWeightsA.txt
rm *.AVGweightA.txt
