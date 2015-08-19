#!/bin/bash
w=($(wc -l bam.filelist))

x=1
while [ $x -le $w ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p bam.filelist"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
        c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

samtools index trimmed_${c2}.fastq.nodup.bam

x=$(( $x + 1 ))

done

