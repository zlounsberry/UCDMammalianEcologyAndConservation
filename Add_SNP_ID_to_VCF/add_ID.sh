#execute this in the directory containing your vcf files to add a SNP ID
#freebayes outputs "." (though there may be an option I need to add to fix that instead...) to this column and plink struggles when assessing linkage.
for i in $(ls *vcf | sed 's/.vcf//g'); do
	echo "Working on $i"
	cat <(grep "#" $i.vcf) <(paste <(grep -v "#" $i.vcf | cut -f1,2) <(grep -v "#" $i.vcf | awk '{print $1_$2}') <(grep -v "#" $i.vcf | cut -f4-)) > $i.WithIDs.vcf
done
