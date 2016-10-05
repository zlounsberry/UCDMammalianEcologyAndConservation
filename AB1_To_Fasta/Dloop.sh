#Example of script used for turning AB1 files into fasta:
makeblastdb -in AllRedFoxDloopHaplotypes.fasta -dbtype 'nucl' -out DLOOP_DB

ls *ab1 > files
~/Desktop/TraceTuner/tracetuner/rel/Linux_64/ttuner -s -if files
cat *ab1.seq > DLOOP_Query.fasta
rm *ab1.seq

blastn -db DLOOP_DB -query DLOOP_Query.fasta -evalue 1e-25 -outfmt 6 -out DLOOP.out

awk '{print $1}' DLOOP.out | sort -u - > seqnames

W=$(wc -l < seqnames)

x=1
while [ $x -le $W ] 
do

      string="sed -n ${x}p seqnames"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
	c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

grep -w "${c1}" DLOOP.out | head -n5 > ${c1}.top_hits.temp.txt
grep -w "${c1}" DLOOP.out | head -n1 > ${c1}.top_hit.temp.txt


x=$(( $x + 1 ))

done

cat header.txt *top_hit.temp.txt > DLOOP.top_hit.txt
cat header.txt *top_hits.temp.txt > DLOOP.top_hits.txt

rm *top_hit.temp.txt
