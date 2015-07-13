#!/bin/bash
x=1
while [ $x -le 144634 ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p Contigs.txt"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
        c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

if grep -qFx ${c1} all-contigs.INFILE_200.filtered.txt ; then
 echo "1" >> INFILE_all.txt
else
 echo "0" >> INFILE_all.txt
fi

if grep -qFx ${c1} poly-contigs.INFILE_200.filtered.txt ; then
 echo "1" >> INFILE_poly.txt
else
 echo "0" >> INFILE_poly.txt
fi

x=$(( $x + 1 ))

done

paste Contigs.txt *_all.txt > all.matrix.txt
paste Contigs.txt *_poly.txt > poly.matrix.txt
