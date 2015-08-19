#./bowtie.sh

##################################################################

W=($(wc -l samplefiles))
GENE=$(echo "IMPG2")
#Change the word IMPG2 in the gene you want to look at. 

#THRESHOLD=$(echo "0.005") #ignore this for now...

#samplefiles is a 2-column, tab delimited file containing your sample IDs in column 1 and the disease state in column 2 (either the disease name or the word 'control'). Looks like this:
	#G232	control
	#G233-1	control
	#G294-1	control
	#G310-1	glaucoma
	#G323	glaucoma
	#G327	glaucoma
	#G328	glaucoma

##################################################################

rm bam.filelist
mkdir output

x=1
while [ $x -le $W ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p samplefiles"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
	c2=$2 #second variable (column 2 in files) This script reads lines one at a time.

ls ../trimmed_${c1}.fastq.nodup.bam > bam1
echo "${c1}" > bam2
echo "${c2}" > bam3
paste bam1 bam2 bam3 >> bam.filelist
rm bam1 bam2 bam3

x=$(( $x + 1 ))

done

./readgroup.sh

./index.sh

./freebayes.sh

##################################################################

grep -e "#" -e "$GENE" ALL.vcf | /usr/bin/vcflib/bin/vcfsnps > ALL.vcf.$GENE
#Here is where your DISEASE variable from the beginning is used!
#Careful, this method ignores INDELs! Will be trying to fix that soon...

##################################################################

/usr/bin/plink1.9/plink --vcf ALL.vcf.$GENE --allow-extra-chr --recode --noweb --out output/plink

rm output/pheno.txt
echo -e "FID\tIID\tpheno" > output/pheno.txt

x=1
while [ $x -le $W ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p samplefiles"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
	c2=$2 #second variable (column 2 in files) This script reads lines one at a time.
	c3=$3

if grep -Fw "${c1}" samplefiles | grep -qFw "control" ; then
	echo -e "${c1}\t${c1}\t1" >> output/pheno.txt
else
	echo -e "${c1}\t${c1}\t2" >> output/pheno.txt
fi

x=$(( $x + 1 ))

done

./plink.sh

./blacklist.sh

awk {'print $3'} output/output.assoc |  grep -v --file blacklisted.$GENE.snps > output/filtersites

rm output/output.filtered.assoc

Y=($(wc -l output/filtersites))

x=1
while [ $x -le $Y ] # "-le " refers to your sample size for the "while loop" (here: 96 samples which is the result of "wc -l files").
do

      string="sed -n ${x}p output/filtersites"

        str=$($string)

        var=$(echo $str | awk -F"\t" '{print $1, $2}')
        set -- $var
        c1=$1 #the first variable (column 1 in files)
        c2=$2 #second variable (column 2 in files) This script reads lines one at a time.
        c3=$3

grep -Fw "${c1}" output/output.assoc >> output/output.filtered.assoc

x=$(( $x + 1 ))

done

rm output/filtersites


##################################################################

awk '$9<0.01' output/output.filtered.assoc > output/output.filtered.cutoffPvalue.assoc
#Change 0.001 to a value to pull P values less than that value. 

##################################################################
