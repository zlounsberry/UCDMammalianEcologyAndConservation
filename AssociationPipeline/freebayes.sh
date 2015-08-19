freebayes -f ../ref.fasta --ploidy 2 --min-coverage 5 --no-mnps --no-complex --min-alternate-count 2 *bam | /usr/bin/vcflib/bin/vcffilter -f "QUAL > 20"  > ALL.vcf

rm *bam *bai
