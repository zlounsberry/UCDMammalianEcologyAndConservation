#!/bin/bash
##I'll update this as I get smarter... Seems to happen rapidly at this stage.

##Things you will need (all free! don't pay for your software):
#fastq-multx (download here: https://code.google.com/p/ea-utils/ go to Google drive and download/unpack it)
#bowtie2 ($sudo apt-get install bowtie2)
#samtools ($sudo apt-get install samtools)
#Trimmomatic ($wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.33.zip, unpack and install or move the .jar file into your PATH)
#Tablet ($wget http://bioinf.hutton.ac.uk/tablet/installers/tablet_linux_x64_1_14_10_21.sh, and running this shell script will open Tablet depending on your settings...)

bowtie2-build -f reference.fasta REF #This builds the reference library for Bowtie2 to read and align to.
samtools faidx reference.fasta #This will be needed to use this reference downstream (to view or whatever)

fastq-multx -B barcodes.fil PathToRawData/*R1Files* PathToRawData/*R2Files* -o r1.%.fq.gz -o r2.%.fq.gz # barcodes.fil is a file of barcodes and individuals that looks like the following (for a single barcode Illumina paired-end, n samples)
#Sample1 (tab) Barcode1
#Sample2 (tab) Barcode2
#Sample3 (tab) Barcode3
#...
#Samplen (tab) Barcoden

#NOTE THAT YOU HAVE TO RUN FASTQ MULTX ON EACH OF THE MULTIPLE FILES AND CONCATENATE THE RESULTS. IF YOUR SEQ CENTER SENT YOU BACK RAW, UNDEMULTIPLEXED FILES, YOU HAVE TO LOOP THIS.
#For my own purposes, see the file remote/zach/Feb_CoyRAD/workflow2.sh. If you`re not me and for some reason you`re reading this, that file loops a loop and requires other scripts because I don't know programming. 

#The following will generate BAM files for each of, in this case, 96 individuals. Just unhash the trimming software you want to use
x=1
while [ $x -le 96 ] #For 96 individuals
do

      string="sed -n ${x}p bardcodes.fil" #barcodes.fil is your file in the current working directory with a list of your samples names in the first column (as above). Below, '${c1}' will be replaced iteratively by sample names

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1}')
        set -- $var
        c1=$1

##You can use ngsShort (I like it)
#perl PATH/ngsShoRT.pl -se ${c1}.R1.fastq.gz -5a_f i-m -o ./trimmed -methods lqr_5adpt_tera #SingleEnd
#perl PATH/ngsShoRT.pl -pe1 ${c1}.R1.fastq.gz -pe2 ${c1}.R2.fastq.gz -5a_f i-m -lqs 25 -o ./trimmed -methods lqr_5adpt_tera #PairedEnd
#bowtie2 -x REF --no-unal --sensitive -1 trimmed/trimmed_${c1}.R1.fastq -2 trimmed/trimmed_${c1}.R2.fastq -U ${c1}.unpaired.fastq -S ${c1}.sam #Going the ngsShort

##You can also use TRIMMOMATIC, which a lot of people use.
#java -jar PATH/trimmomatic-0.33.jar PE -phred33 ${c1}.R1.fastq.gz ${c1}.R2.fastq.gz ${c1}.R1.paired.fastq.gz ${c1}.R1.unpaired.fastq.gz ${c1}.R2.paired.fastq.gz ${c1}.R2.unpaired.fastq.gz SLIDINGWINDOW:4:15 MINLEN:40
#The previous line will quality trim your R1 and R2 files and output files for the paired and unpaired reads.
#zcat ${c1}.R1.unpaired.fastq.gz ${c1}.R2.unpaired.fastq.gz > ${c1}.unpaired.fastq #concatenates the read1 and read2 unpaired files into a single file
#rm ${c1}.R1.unpaired.fastq.gz ${c1}.R2.unpaired.fastq.gz #Housekeeping...
#bowtie2 -x REF --no-unal --sensitive -1 ${c1}.R1.paired.fastq.gz -2 ${c1}.R2.paired.fastq.gz -U ${c1}.unpaired.fastq -S ${c1}.sam #Going the ngsShort

samtools view -bS ${c1}.sam | samtools sort - ${c1} # Convert SAM to BAM format and sort the BAM file.
#samtools rmdup -S ${c1}.bam > ${c1}.nodup.bam #This line will remove duplicates from single end reads. Leave the -S flag off if your reads are paired (this isn't great for single-end reads anyway, I think)
#samtools depth ${c1}.bam > ${c1}.depth.txt #This prints the per-site coverage for all covered sites to a text file
#samtools index ${c1}.bam #Index your bam file for viewing, etc.
rm ${c1}.sam # Remove large SAM file

x=$(( $x + 1 ))

done

#Now it never hurts to look at your BAM files in something like Tablet to make sure they make sense. Obviously you don't want to check every base of all assemblies, but visualizing your data is important!
