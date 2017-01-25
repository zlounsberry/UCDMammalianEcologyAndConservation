setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/HaplotypeNetwork")
library(pegas) 
library(dplyr)

x = read.dna(file="test_YChrom2.fas", format="fasta")
x = read.dna(file="test_YChrom_test.fas", format="fasta")
h = haplotype(x, labels=NULL)
net <- haploNet(h)
dev.new(width=80, height=40)
#tiff("NewfoundlandRF_Network.tiff", width=80, height=40) #This stupid command doesn't work.
plot(net, size=attr(net,"freq"), pie=haploFreq(x, what=1, haplo=h), scale.ratio=1, lwd=4, adj=(y=0), labels=F, show.mutation=1, threshold=0)
	#size=attr(net,"freq") will make each node the size of its respective frequency. In this case, it makes it too big... So I did that "size=c(40,...2) to scale better
	#pie=haploFreq(x, what=1, haplo=h) makes a matrix of values to put in the pie charts. Honestly, the "what=#" is important and poorly documented. 1 worked here...
legend(15,3, colnames(head(haploFreq(x, what=1, haplo=h),1)), col=rainbow(ncol(head(haploFreq(x, what=1, haplo=h),1))), pch=20, cex=2, pt.cex=3)


##other options:
#fq=attr(net,"freq") 
#length(seg.sites(x))
#haploFreq(x)
#unique(labels(x))


