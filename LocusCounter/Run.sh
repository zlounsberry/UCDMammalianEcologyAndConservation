#bowtie2-build -f Contigs.200.fa 200

#echo -e "SampleName\tTotalLoci\tPolymorphic" > HeteroBySample.txt

#!/bin/bash
x=1
while [ $x -le 14 ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do
      string="sed -n ${x}p files"

        str=$($string)
        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
        c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

#bowtie2 -x 200 --very-sensitive --no-unal -1 ~/data/ArcticFox/Full/trimmed/trimmed_${c1}.R1.fq.gz -2 ~/data/ArcticFox/Full/trimmed/trimmed_${c1}.R2.fq.gz -U ~/data/ArcticFox/Full/trimmed/${c1}.se.fastq.gz -S ${c1}.sam
#samtools view -bS ${c1}.sam | \
#samtools sort - ${c1}_200
#samtools rmdup ${c1}_200.bam ${c1}_200.nodup.bam
#samtools depth ${c1}_200.nodup.bam | awk 'int($3)>=6' - | awk 'int($3)<=400' - | sort -buk1,1 | sed 's/[\t].*$//'> all-contigs.${c1}_200.filtered.txt
#wc -l all-contigs.${c1}_200.filtered.txt | sed 's/[ ].*$//' > all

ls ${c1}_200.nodup.bam > bam.filelist
/usr/bin/angsd/angsd -bam bam.filelist -out results/${c1}.200.filtered.angsd -doMaf 1 -GL 1 -doMajorMinor 1 -setMinDepth 6 -setMaxDepth 400 -doCounts 1 -doDepth 1 -nInd 1 -SNP_pval 1e-4
zcat results/${c1}.200.filtered.angsd.mafs.gz | sort -buk1,1 | sed 's/[\t].*$//' - > poly-contigs.${c1}_200.filtered.txt
wc -l poly-contigs.${c1}_200.filtered.txt | sed 's/[ ].*$//' >> polyFill

#echo "${c1}" > name
#paste name all poly >> HeteroBySample.txt
#rm *sam poly all name

x=$(( $x + 1 ))

done
