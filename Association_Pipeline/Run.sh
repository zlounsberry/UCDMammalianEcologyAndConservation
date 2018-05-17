#!/bin/bash
##Usage: ./Run.sh [paired=pe/single=se] [reference.fasta] [path to input file(s)] [path to output file(s)] [date you called SNPs as YEARMMDD] [name of project]
#example: ./Run.sh pe CanFam3.fa "/InputPath/data" "bamfiles" 20170401 Cute_Puppy_SNP_Calling
#requires: tab-delim 2-col file "samplefiles" with sample name (matches fastq file) and case (0) vs control (1) identifier
#example:
#Sample1	1
#Sample2	1
#Sample3	2

if ls | grep -q samplefiles; then

Pairing=$1
Reference=$2
Path_To_Input=$3
Output_Directory=$4
Date_Of_SNP_Calling=$5
Project_ID=$6

mkdir ${Output_Directory}

if ls ${Reference}* | grep -q ${Reference}.bwt; then
	echo "There is already a bwa reference for this, continuing"
else
	echo "There is not already a bwa reference for this, creating one"
	bwa index ${Reference}
fi

for Input in $(awk '{print $1}' samplefiles); do
	if [[ ${Pairing} == "pe" ]]; then
		./Align_To_Reference_pe.sh ${Reference} ${Path_To_Input} ${Input} ${Output_Directory}
	else
		if [[ ${Pairing} == "se" ]]; then
			./Align_To_Reference_se.sh ${Reference} ${Path_To_Input} ${Input} ${Output_Directory}
		else
			echo "Sorry for the confusion, but you need to specify if your input fastq files are paired end 'pe' or single end 'se' (see usage)"
		fi
	fi
done

freebayes -f ${Reference} ${Output_Directory}/*bam | /usr/bin/vcflib/bin/vcffilter -f "QUAL > 15" | /usr/bin/vcflib/bin/vcfbreakmulti > ${Output_Directory}/${Date_Of_SNP_Calling}_${Project_ID}.vcf
	#Use some options! They are too project-specific for me to generically include, but check out https://github.com/ekg/freebayes and also see what papers doing similar things are doing.

echo -e "FID\tIID\tpheno" > ${Output_Directory}/pheno.txt

W=$(wc -l < samplefiles)

x=1
while [ $x -le $W ]
do

      string="sed -n ${x}p samplefiles"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2, $3}')
        set -- $var
        Input=$1 #the first variable (column 1 in files)
	Phenotype=$2 #second variable (column 2 in files) This script reads lines one at a time.

echo -e "${Input}\t${Input}\t${Phenotype}" >> ${Output_Directory}/pheno.txt

x=$(( $x + 1 ))
done

/usr/bin/plink1.9/plink --vcf ${Output_Directory}/${Date_Of_SNP_Calling}_${Project_ID}.vcf --pheno ${Output_Directory}/pheno.txt --assoc --allow-no-sex --double-id --recode tab --allow-extra-chr --out ${Output_Directory}/${Date_Of_SNP_Calling}_${Project_ID}

cat <(head -n1 ${Output_Directory}/${Date_Of_SNP_Calling}_${Project_ID}.assoc) <(awk '$9<0.05' ${Output_Directory}/${Date_Of_SNP_Calling}_${Project_ID}.assoc) > ${Output_Directory}/${Date_Of_SNP_Calling}_${Project_ID}.Filtered.assoc

else
	echo 'please check that there is a file called "samplefiles" in your current directory and try again'
fi
