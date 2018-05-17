#!/bin/bash
set -x
##Check to make sure your data are in the format I use here (i.e., how it comes back to me from UCD genome center...). If not, make changes to the input.
##IMPORTANT: If you have multiple files with the same name/prefix, this script will break. That's bad practice, IMHO. Please at least do like sample1_1 and sample1_2 next time.
##Usage: ./Run.sh [paired=pe/single=se] [reference.fasta] [path to input file(s)] [path to output file(s)] [date you called SNPs as YEARMMDD] [name of project]
#example: ./Run.sh pe CanFam3.fa "/InputPath/data" "bamfiles" 20170401 Cute_Puppy_SNP_Calling

Pairing=$1
Reference=$2
Path_To_Input=$3
Output_Directory=$4
Date_Of_SNP_Calling=$5
Project_ID=$6

mkdir ${Output_Directory}

##Check if a BWA reference is already present. If not, make one.
if ls ${Reference}* | grep -q ${Reference}.bwt; then
	echo "There is already a bwa reference for this, continuing"
else
	echo "There is not already a bwa reference for this, creating one"
	bwa index ${Reference}
fi

##Get a list of your files. This is the bit that you may need to change depending on your data
if [[ ${Pairing} == "pe" ]]; then
	paste <(ls ${Path_To_Input}*R1*) <(ls ${Path_To_Input}*R2*) <(ls ${Path_To_Input}*R1* | sed 's/^.*[\/]//' | sed 's/.R1.*$//') > files.txt
else
	 if [[ ${Pairing} == "se" ]]; then
		paste <(ls ${Path_To_Input}*R1*) <(ls ${Path_To_Input}*R1* | sed 's/^.*[\/]//' | sed 's/.R1.*$//') > files.txt
	else
		echo "Sorry for the confusion, but you need to specify if your input fastq files are paired end 'pe' or single end 'se' (see usage)"
		exit 0
	fi
fi

##Counting the number of files you have, this loop will run on the file you created (files.txt)

if [[ ${Pairing} == "pe" ]]; then
	Lines=$(wc -l < files.txt)
	x=1
	while [ $x -le $Lines ]
	do
		string="sed -n ${x}p files.txt"
	        str=$($string)
	        var=$(echo $str | awk -F"\t" '{print $1, $2, $3}')
	        set -- $var
	        R1=$1 #the first variable (column 1 in files)
		R2=$2 #second variable (column 2 in files) This script reads lines one at a time.
		ID=$3 #you get the idea

		echo "Aligning ${Path_To_Input}/${Input}.fastq.gz to ${Reference}"

		bwa mem -R "@RG\tID:${ID}\tSM:${ID}" ${Reference} ${R1} ${R2} > ${Output_Directory}/${ID}.sam
	        	#bwa with default parameters, just adding a readgroup to each sample
		samtools view -F 4 -q 10 -bS ${Output_Directory}/${ID}.sam | samtools sort - ${Output_Directory}/${ID}
		        #samtools: -F 4 flag tells it to remove unmapped reads; -q 10 tells it to remove reads that have a 0.1 likelihood to be mapped incorrectly (based on MAPQ score)
		picard-tools MarkDuplicates I=${Output_Directory}/${ID}.bam O=${Output_Directory}/${ID}_nodup.bam M=Metrics
		        #mark PCR clones
		samtools rmdup ${Output_Directory}/${ID}_nodup.bam ${Output_Directory}/${ID}.bam
		        #remove PCR clones (NOT recommended for GBS-type lanes!)
		samtools index ${Output_Directory}/${ID}.bam
		        #Index BAM file
		rm ${Output_Directory}/${ID}_nodup.bam ${Output_Directory}/${ID}.sam
		        #clean up temp files
	x=$(( $x + 1 ))
	done
else
	Lines=$(wc -l < files.txt)
        x=1
        while [ $x -le $Lines ]
        do
		string="sed -n ${x}p files.txt"
		str=$($string)
		var=$(echo $str | awk -F"\t" '{print $1, $2}')
		set -- $var
		R1=$1 #the first variable (column 1 in files)
		ID=$2 #second variable (column 2 in files) This script reads lines one at a time.

	        bwa mem -R "@RG\tID:${ID}\tSM:${ID}" ${Reference} ${R1} > ${Output_Directory}/${ID}.sam
	                #bwa with default parameters, just adding a readgroup to each sample
	        samtools view -F 4 -q 10 -bS ${Output_Directory}/${ID}.sam | samtools sort - ${Output_Directory}/${ID}
	                #samtools: -F 4 flag tells it to remove unmapped reads; -q 10 tells it to remove reads that have a 0.1 likelihood to be mapped incorrectly (based on MAPQ score)
	        picard-tools MarkDuplicates I=${Output_Directory}/${ID}.bam O=${Output_Directory}/${ID}_nodup.bam M=Metrics
	                #mark PCR clones; note this is a bad idea for reduced representation on SE data (e.g., GBS, RAD) because they all look like clones...
	        samtools rmdup ${Output_Directory}/${ID}_nodup.bam ${Output_Directory}/${ID}.bam
	                #remove PCR clones (NOT recommended for GBS-type lanes!)
	        samtools index ${Output_Directory}/${ID}.bam
        	        #Index BAM file
	        rm ${Output_Directory}/${ID}_nodup.bam ${Output_Directory}/${ID}.sam
	                #clean up temp files

	x=$(( $x + 1 ))
	done
fi

freebayes -f ${Reference} ${Output_Directory}/*bam | /usr/bin/vcflib/bin/vcffilter -f "QUAL > 15" > ${Output_Directory}/${Date_Of_SNP_Calling}_${Project_ID}.vcf
	#Use some options! They are too project-specific for me to generically include, but check out https://github.com/ekg/freebayes and also see what papers doing similar things are doing.

