##Usage: './SortSeq.sh EXTENSION' #where EXTENSION is the date, proj ID, whatever. Something to ID the file directories.

VAR=$1

mkdir DLoopOutput
for i in $(awk '{print $2}' DLOOP.top_hit.txt | sort -u | grep -v 'subject'); do
		rm -r DLoopOutput/$VAR_$i
	mkdir DLoopOutput/$VAR_$i
	awk -v var=$i '($2==var) {print $1}' DLOOP.top_hit.txt > DLoopOutput/$VAR.$i.files.txt
	for j in $(cat DLoopOutput/$VAR.$i.files.txt); do
		cp $j DLoopOutput/$VAR_$i
	done
	grep -A1 -Fw ">$i" AllRedFoxDloopHaplotypes.fasta > DLoopOutput/$VAR_$i/$i.fasta
done
