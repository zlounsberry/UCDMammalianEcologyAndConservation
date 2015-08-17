for i in *.nodup.bam; do
    freebayes -f Dog_FullY.masked.diplocut.fas --ploidy 1 --min-coverage 2 --no-mnps --no-complex --report-monomorphic --min-alternate-count 2 $i |  grep -v -e "TYPE=del" -e "TYPE=ins" > $i.vcf
done

freebayes -f Dog_FullY.masked.diplocut.fas --ploidy 1 --min-coverage 2 --no-mnps --no-complex --min-alternate-count 2 *nodup.bam | /usr/bin/vcflib/bin/vcffilter -f "QUAL > 20" | /usr/bin/vcflib/bin/vcfsnps > ALL.maskedY.vcf

