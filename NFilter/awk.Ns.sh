#!/bin/bash
#This script filters out fasta files with a certain proportion of N's. 
#I primarily use it for de novo assemblies that I ran through repeatmasker. Might be useful for other things. Who knows
#You can just $sed -i 's/INFILE.fasta/YOUR_FILE_NAME.fasta/g' it

y=($(wc -l INFILE.fasta)) # Makes a variable 'y' that is the number of lines in your infile
(seq 2 2 $y) > numbers #Makes a file 'numbers' that is every other number in your file
z=($echo $(($y/2))) #This makes a variable 'z' that is the number of sequences in your file (half the number of lines in your file) 

#This next part is a loop. To be honest I'm not 100% sure how it works. I borrowed it from Mike Miller here at UCD.
x=1
while [ $x -le $z ] # This bit says to use the 'z' number of x variables in your loop (so use all the sequences in the file
do

      string="sed -n ${x}p numbers"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
        c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

sequence=($(awk "NR==${c1}" INFILE.fasta | awk '{print length}' -)) # This prints the length of the sequence
Ns=($(awk "NR==${c1}" INFILE.fasta | grep -o "N" - | wc -l)) #This counts the number of N's in the sequence
Prop=($(awk "BEGIN { print ( $Ns / $sequence ) }")) #This makes a variable that is the number of Ns compared to length of sequence (proportion of Ns)

if (( $(echo "$Prop > 0.6" | bc -l) )) #Here I use 60% Ns as a cut-off to remove. It compares the proportion of Ns to your cutoff and, if there are too many Ns, prints it to the file "TooManyNs.fasta." Otherwise it saves it to Saved.fasta
        then
                head -n${c1} INFILE.fasta | tail -n2 >> TooManyNs.fasta
        else
                head -n${c1} INFILE.fasta | tail -n2 >> Saved.fasta
fi

x=$(( $x + 1 ))

done

date +"%m/%d %H:%M:%S this finally finished" #This prints the time and date it finished because why not

