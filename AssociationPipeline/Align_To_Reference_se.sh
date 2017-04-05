#!/bin/bash
Reference=$1
Path_To_Input=$2
Input=$3
Output_Directory=$4

echo "Aligning ${Path_To_Input}${Input}.fastq.gz to ${Reference}"

bwa mem -R "@RG\tID:${Input}\tSM:${Input}" ${Reference} ${Path_To_Input}${Input}_R1_001.fastq.gz ${Path_To_Input}${Input}_R2_001.fastq.gz > ${Output_Directory}/${Input}.sam
	#bwa with default parameters, just adding a readgroup to each sample
samtools view -F 4 -q 10 -bS ${Output_Directory}/${Input}.sam | samtools sort - ${Output_Directory}/${Input}
	#samtools: -F 4 flag tells it to remove unmapped reads; -q 10 tells it to remove reads that have a 0.1 likelihood to be mapped incorrectly (based on MAPQ score)
picard-tools MarkDuplicates I=${Output_Directory}/${Input}.bam O=${Output_Directory}/${Input}_nodup.bam M=Metrics
	#mark PCR clones
samtools rmdup ${Output_Directory}/${Input}_nodup.bam ${Output_Directory}/${Input}.bam
	#remove PCR clones (NOT recommended for GBS-type lanes!)
samtools index ${Output_Directory}/${Input}.bam
	#Index BAM file
rm ${Output_Directory}/${Input}_nodup.bam ${Output_Directory}/${Input}.sam
	#clean up temp files

