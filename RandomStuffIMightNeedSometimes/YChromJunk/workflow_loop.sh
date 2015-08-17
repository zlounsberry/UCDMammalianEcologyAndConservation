#!/bin/bash

#./freebayes.sh
grep -v "#" ALL.maskedY.vcf | awk '{print $2}' > SNPsites

rm retained.txt ommitted.txt
./retain.sh

ls *bam.vcf > vcf.filelist
VCF=($(wc -l vcf.filelist))

x=1
while [ $x -le $VCF ] # "-le " refers to your sample size for the "while loop"
do

      string="sed -n ${x}p vcf.filelist"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1}')
        set -- $var
        c1=$1

	./change_workflow_file.sh ${c1}
	./workflow.sh
	./change_workflow_file_back.sh ${c1}

x=$(( $x + 1 ))

done

cat *vcf.fasta > all.vcf.fasta
sed -i 's/>/\n>/g' all.vcf.fasta

