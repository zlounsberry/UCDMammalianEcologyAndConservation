Input_file=$1

##Usage: ./Count_ROH_Haplotypes.sh [SAMPLE].hom.overlap

mkdir Haplotype_Counts_By_Year
mkdir SNP_Subset
mkdir PLINK_Output
mkdir Shapeit_Output
mkdir GHap
mkdir scripts
mkdir GHap_Output

for SNP in $(awk '{print $1}' ${Input_file} | sort -u | grep -v POOL); do
	awk -v var=${SNP} '($1==var) {print}' ${Input_file} > temp.${SNP}.txt
	echo "Starting on ${SNP}"
	Chromosome=$(awk -v var=${SNP} '($1==var) {print $5}' temp.${SNP}.txt | sort -u)
	Start_Overlap=$(awk -v var=${SNP} '($1==var) {print $8}' temp.${SNP}.txt | sort -n | tail -n1)
	Finish_Overlap=$(awk -v var=${SNP} '($1==var) {print $9}' temp.${SNP}.txt | sort -n | head -n1)
	Length=$(echo "${Finish_Overlap} - ${Start_Overlap}" | bc)
	rm temp.${SNP}.txt
	if [[ "${Length}" -lt 100000 ]]; then
		echo "Too short, moving on!"
	else
		awk -v Chr=${Chromosome} -v Start=${Start_Overlap} -v End=${Finish_Overlap} '($1==Chr) && ($4>Start) && ($4<End) {print $2}' TB2.map > SNP_Subset/${SNP}.Total.Sites.txt

		/usr/bin/plink1.9-dev --file TB2 --mind 0.8 --geno 0.2 --make-bed --recode tab --chr-set 38 --allow-extra-chr --extract SNP_Subset/${SNP}.Total.Sites.txt --out PLINK_Output/${SNP} # --keep samples.${SNP}.txt
		rm samples.${SNP}.txt
		Markers=$(wc -l < PLINK_Output/${SNP}.map)

		#Phase the files
		~/shapeit/bin/shapeit --input-bed PLINK_Output/${SNP}.bed PLINK_Output/${SNP}.bim PLINK_Output/${SNP}.fam --output-max Shapeit_Output/${SNP}.phased.haps Shapeit_Output/${SNP}.phased.sample

		#Make GHap files from Shapeit
		tail -n +3 Shapeit_Output/${SNP}.phased.sample | cut -d' ' -f1,2 > GHap/${SNP}.samples
		cut -d' ' -f1-5 Shapeit_Output/${SNP}.phased.haps > GHap/${SNP}.markers
		cut -d' ' -f1-5 --complement Shapeit_Output/${SNP}.phased.haps > GHap/${SNP}.phase

		for Date in $(echo "1987        1994    2001    2008    2015"); do
	                echo "library(GHap)
	                phase <- ghap.loadphase('GHap/${SNP}.samples','GHap/${SNP}.markers','GHap/${SNP}.phase')
#			#I removed the maf calculations because it was resulting in pretty much entirely empty files (since these are so small?)#
#	                maf <- ghap.maf(phase)
#	                markers <- phase\$marker[maf > 0.05]
#	                phase <- ghap.subsetphase(phase, unique(phase\$id), markers)
	                blocks.mkr <- ghap.blockgen(phase, windowsize = ${Markers}, slide = 5, unit = 'marker')
	                ghap.haplotyping(phase, blocks.mkr, batchsize = 100, outfile = 'GHap/${Date}_${SNP}_GHap')
	                haplo <- ghap.loadhaplo('GHap/${Date}_${SNP}_GHap.hapsamples','GHap/${Date}_${SNP}_GHap.hapalleles','GHap/${Date}_${SNP}_GHap.hapgenotypes')
	                x${Date}.ids <- haplo\$id[which(haplo\$pop=='${Date}')]
	                haplo${Date} <- ghap.subsethaplo(haplo,x${Date}.ids,haplo\$allele.in)
	                hapstats${Date} <- ghap.hapstats(haplo${Date})
	                write.csv(hapstats${Date}, file='GHap_Output/hapstats.${Date}.${SNP}.txt', quote=F)" > scripts/GHAP.${SNP}.${Date}.R
	                Rscript scripts/GHAP.${SNP}.${Date}.R
		done

			echo "x1987=read.csv('GHap_Output/hapstats.1987.${SNP}.txt', header=T)
			x1994=read.csv('GHap_Output/hapstats.1994.${SNP}.txt', header=T)
			x2001=read.csv('GHap_Output/hapstats.2001.${SNP}.txt', header=T)
			x2008=read.csv('GHap_Output/hapstats.2008.${SNP}.txt', header=T)
			x2015=read.csv('GHap_Output/hapstats.2015.${SNP}.txt', header=T)
			png('Haplotype_Counts_By_Year/${SNP}.distribution.png', height=15, width=25,units='in', res=100)
			par(mfrow=c(2,3))
			plot.new()
			text(.5,.5,\"${SNP}\n${Markers} SNPS\n${Length} bp region\", cex=4)
			barplot(x1987\$N,space=0.05,xlab='Haplotype',ylab='Copy Count', main='1987', col='darkblue')
			barplot(x1994\$N,space=0.05,xlab='Haplotype',ylab='Copy Count', main='1994', col='goldenrod1')
			barplot(x2001\$N,space=0.05,xlab='Haplotype',ylab='Copy Count', main='2001', col='darkblue')
			barplot(x2008\$N,space=0.05,xlab='Haplotype',ylab='Copy Count', main='2008', col='goldenrod1')
			barplot(x2015\$N,space=0.05,xlab='Haplotype',ylab='Copy Count', main='2015', col='darkblue')
			dev.off()" > scripts/Plot.${SNP}.R
			Rscript scripts/Plot.${SNP}.R

		for File in $(ls GHap_Output/*.${SNP}.*); do
			Total_haplotypes=$(grep -v ALLELE ${File} | wc -l)
			Number_haplotypes=$(awk -F',' '($7>0) {print}' ${File} | wc -l)
			Total_individuals=$(awk -F',' '{print $7}' ${File} | awk '{sum+=$1} END {print sum}')
			Max_Haplot_Count=$(awk -F',' '{print $7}' ${File} | sort -nr | head -n1)
			Proportion=$(echo "${Max_Haplot_Count} / ${Total_individuals}" | bc -l)
			echo "${File}	${Total_haplotypes}	${Number_haplotypes} ${Proportion}"
		done > Haplotype_Counts_By_Year/${SNP}.Count.By.Year

	fi



rm shapeit*

done
