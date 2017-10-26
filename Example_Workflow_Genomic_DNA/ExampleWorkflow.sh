#!/bin/bash
##Some variables to make this easy to execute

#Example usage: ./ExampleWorkflow.sh PATHTORAW reference.fasta

PathToRawData=$1
ReferenceFasta=$2

##I'll update this as I get smarter... Seems to happen rapidly at this stage.

##Things you will need (all free! don't pay for your software):
#fastq-multx ($git clone https://github.com/brwnj/fastq-multx)
#bowtie2 ($sudo apt-get install bowtie2)
#samtools ($sudo apt-get install samtools)
#Trimmomatic ($wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.33.zip, unpack and install or move the .jar file into your PATH)
#Alternatively, ngsShort (http://research.bioinformatics.udel.edu/genomics/ngsShoRT/)
#Tablet ($wget http://bioinf.hutton.ac.uk/tablet/installers/tablet_linux_x64_1_14_10_21.sh, and running this shell script will open Tablet depending on your settings...)

bowtie2-build -f $ReferenceFasta REF #This builds the reference library for Bowtie2 to read and align to.
samtools faidx $ReferenceFasta #This will be needed to use this reference downstream (to view or whatever)

fastq-multx -B barcodes.fil $PathToRawData/*R1* $PathToRawData/*R2* -o %.R1.fastq.gz -o %.R2.fastq.gz # barcodes.fil is a file of barcodes and individuals that looks like the following (for a single barcode Illumina paired-end, n samples)
#Sample1 (tab) Barcode1
#Sample2 (tab) Barcode2
#Sample3 (tab) Barcode3
#...
#Samplen (tab) Barcoden

#NOTE THAT YOU HAVE TO RUN FASTQ MULTX ON EACH OF THE MULTIPLE FILES AND CONCATENATE THE RESULTS. IF YOUR SEQ CENTER SENT YOU BACK RAW, UNDEMULTIPLEXED FILES, YOU HAVE TO LOOP THIS.
#For my own purposes, see the file remote/zach/Feb_CoyRAD/workflow2.sh. If you`re not me and for some reason you`re reading this, that file loops a loop and requires other scripts because I don't know programming. 

#The following will generate BAM files for each of, in this case, 96 individuals. Just unhash the trimming software you want to use

W=$(wc -l < barcodes.fil)
mkdir trimmed

x=1
while [ $x -le $W ]
do

      string="sed -n ${x}p barcodes.fil" #barcodes.fil is your file in the current working directory with a list of your samples names in the first column (as above). Below, '${c1}' will be replaced iteratively by sample names

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1}')
        set -- $var
        c1=$1

##You can use ngsShort (I like it)
perl ngsShoRT.pl -se ${c1}.R1.fastq.gz -5a_f i-m -o ./trimmed -methods lqr_5adpt_tera-gzip #SingleEnd
perl ngsShoRT.pl -pe1 ${c1}.R1.fastq.gz -pe2 ${c1}.R2.fastq.gz -5a_f i-m -lqs 25 -o ./trimmed -methods lqr_5adpt_tera-gzip #PairedEnd
bowtie2 -x REF --no-unal --sensitive -1 trimmed/trimmed_${c1}.R1.fastq.gz -2 trimmed/trimmed_${c1}.R2.fastq.gz -U ${c1}.unpaired.fastq.gz -S ${c1}.sam

##You can also use TRIMMOMATIC, which a lot of people use.
#java -jar PATH/trimmomatic-0.33.jar PE -phred33 ${c1}.R1.fastq.gz ${c1}.R2.fastq.gz ${c1}.R1.paired.fastq.gz ${c1}.R1.unpaired.fastq.gz ${c1}.R2.paired.fastq.gz ${c1}.R2.unpaired.fastq.gz SLIDINGWINDOW:4:15 MINLEN:40
#zcat ${c1}.R1.unpaired.fastq.gz ${c1}.R2.unpaired.fastq.gz > ${c1}.unpaired.fastq #concatenates the read1 and read2 unpaired files into a single file
#bowtie2 -x REF --no-unal --sensitive -1 ${c1}.R1.paired.fastq.gz -2 ${c1}.R2.paired.fastq.gz -U ${c1}.unpaired.fastq -S ${c1}.sam

samtools view -bS ${c1}.sam | samtools sort - ${c1} # Convert SAM to BAM format and sort the BAM file.
picard-tools MarkDuplicates I=${c1}.bam O=${c1}_nodup.bam M=Metrics
samtools rmdup ${c1}_nodup.bam > ${c1}.nodup.bam #This line will remove duplicates from paired end reads. Add the -S flag if your reads are unpaired (this isn't great for single-end reads anyway, I think)
samtools depth ${c1}.nodup.bam > ${c1}.depth.txt #This prints the per-site coverage for all covered sites to a text file
samtools index ${c1}.nodup.bam #Index your bam file for viewing, etc.
rm ${c1}.sam ${c1}.bam ${c1}_nodup.bam # Remove large SAM file and intermediate BAM files. Maybe one day I will pipe those if I can...

x=$(( $x + 1 ))

done

#Now it never hurts to look at your BAM files in something like Tablet to make sure they make sense. Obviously you don't want to check every base of all assemblies, but visualizing your data is important!
