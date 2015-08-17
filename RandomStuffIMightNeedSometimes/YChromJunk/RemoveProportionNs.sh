#!/bin/bash
#This script filters out fasta files with a certain proportion of N's. 
#I primarily use it for outputs of de novo assemblies that I ran through repeatmasker. Might be useful for other things. Who knows?
#You can just $sed -i 's/FILE.fasta/YOUR_FILE_NAME.fasta/g' it

rm Saved.fasta TooManyNs.fasta
y=($(wc -l all.vcf.fasta)) # Makes a variable 'y' that is the number of lines in your infile
(seq 2 2 $y) > numbers #Makes a file 'numbers' that is every other number in your file
(seq 1 2 $y) > names
paste numbers names > file
z=$(($y/2)) #This makes a variable 'z' that is the number of sequences in your file (half the number of lines in your file) 


#This next part is a loop. To be honest I'm not 100% sure how it works. I borrowed it from Mike Miller here at UCD.
x=1
while [ $x -le $z ] # This bit says to use the 'z' number of x variables in your loop (so use all the sequences in the file)
do

      string="sed -n ${x}p file"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
        c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

sequence=($(awk "NR==${c1}" all.vcf.fasta)) #Store every other sequence iteratively as a variable
name=($(awk "NR==${c2}" all.vcf.fasta))
Ns=($(echo "$sequence" | grep -o "N" - | wc -l)) # Count the number of N's in your sequence and store it as a variable
len=($(echo "$sequence" | awk '{print length}')) # Count the length of the sequence and store it as a variable
Prop=($(awk "BEGIN { print ( $Ns / $len ) }")) # Calculcates the proportion of N's

if (( $(echo "$Prop > 0.2" | bc -l) )) # If your proportion is greater than your cutoff (here 50%), print to a file TooManyNs.fasta. Otherwise print to Saved.fasta (the file you want to use)
        then
                echo -e "$name\n$sequence" >> Saved.fasta
        else
                echo -e "$name\n$sequence" >> TooManyNs.fasta
fi

x=$(( $x + 1 ))

done

rm names numbers file
