#!/bin/bash

bowtie2-build -f ref.fasta ref

ls *NoClones/*fq_1.gz > files1
ls *NoClones/*fq_2.gz > files2
paste files1 files2 > files

W=($(wc -l files))

x=1
while [ $x -le $W ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p files"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
        c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

bowtie2 --no-unal --sensitive -x ref -1 ${c1} -2 ${c2} -S ${c1}.sam 
samtools view -bS ${c1}.sam | samtools sort - ${c1}
picard-tools MarkDuplicates I=${c1}.bam O=${c1}_nodup.bam M=Metrics
samtools rmdup ${c1}_nodup.bam ${c1}.nodup.bam
rm ${c1}.bam ${c1}_nodup.bam ${c1}.sam

x=$(( $x + 1 ))

done

ls *bam > bam1
sed 's/[.].*$//' bam.filelist | awk '{ k=split($1,a,"_");print a[k] }' > bam2
paste bam1 bam2 > bam.filelist
rm bam1 bam2
