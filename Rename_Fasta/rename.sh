#!/bin/bash
##USAGE: ./rename.sh [FILE_TO_RENAME] [FILE_CONTAINING_OLD_NAMES_AND_NEW_NAMES] [Nth_Delimiter_Position]
#for i in $(grep ">" ${file_to_rename} | sed "s/>//g"); do paste <(echo $i) <(echo $i | cut --delimiter="_" -f2); done
file_to_rename=$1
file_with_names=$2
delimiter_position=$3

#Bit of a special case, but wanted the script to be able to take the Nth field of an underscore-delimited sequence name (e.g., from an ABI 3730) and replace the whole name with just the contents of this field.
if [ -n "${delimiter_position}" ]; then
	for i in $(grep ">" ${file_to_rename} | sed "s/>//g"); do paste <(echo $i) <(echo $i | cut --delimiter="_" -f${delimiter_position}); done > ${file_with_names}
fi

#If you don't specify a value for delimiter_position, then you need to provide FILE_CONTAINING_OLD_NAMES_AND_NEW_NAMES as a 2-col, tab-delim text file and specify it as per the usage above.
cp ${file_to_rename} backup.fasta

file_length=$(wc -l < ${file_with_names})

x=1
while [ $x -le ${file_length} ]
do

      string="sed -n ${x}p ${file_with_names}"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2, $3}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
	c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

sed -i "s/\b${c1}\b/${c2}/g" ${file_to_rename}

x=$(( $x + 1 ))
done

#now just for fun, make sure the sequences match what they are supposed to! 

makeblastdb -in backup.fasta -dbtype 'nucl' -out CheckTest
blastn -db CheckTest -query  ${file_to_rename} -outfmt 6 -out CheckTest.out

for query_ID in $(awk '{print $1}' CheckTest.out | sort -u); do
	paste <(awk -v var=${query_ID} '($1==var) {print}' CheckTest.out | sort -g -k11 | head -n1 | awk '{print $2}') <(awk -v var=${query_ID} '($1==var) {print}' CheckTest.out | sort -g -k11 | head -n1 | awk '{print $1}')
done > CheckTest.txt

if cmp <(sort -k1,1 ${file_with_names}) <(sort -k1,1 CheckTest.txt); then
	echo "Everything looks good, your files should have their new names"
	rm backup.fasta CheckTest*
else
	echo "Something went wrong and the new names do not match the old ones! Check it out:"
	paste <(sort -k1,1 ${file_with_names}) <(sort -k1,1 CheckTest.txt)
fi
