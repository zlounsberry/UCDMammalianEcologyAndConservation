setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/HaplotypeNetwork")
library(pegas) 
library(dplyr)

#IMPORTANT NOTES:
	#ALL '-' CHARACTERS WERE REPLACED WITH N'S IN THIS FILE. THIS MEANS THAT F85 AND F79 WERE IDENTICAL. THIS CAUSED THE PROGRAM TO LUMP THEM TOGETHER
	#THE FILE USED HERE HAS HAD THOSE N'S REPLACED WITH T'S. THIS MAKES EVERYTHING DISPLAY CORRECTLY.

x = read.dna(file="NewfoundlandRF_FormattedForPegas.fas", format="fasta")
h = haplotype(x, labels=c("","","","\nF274","\nF275","\nF85 ","\n  F79","","",""))
net <- haploNet(h)
dev.new(width=80, height=40)
#tiff("NewfoundlandRF_Network.tiff", width=80, height=40) #This stupid command doesn't work.
plot(net, size=c(40,3,3,2,2,2,2,10,4,2), pie=haploFreq(x, what=1, haplo=h), bg=c("gray50","black"), scale.ratio=6, lwd=4, adj=(y=0), labels=T, cex=5, show.mutation=0, threshold=0)
	#size=attr(net,"freq") will make each node the size of its respective frequency. In this case, it makes it too big... So I did that "size=c(40,...2) to scale better
	#pie=haploFreq(x, what=1, haplo=h) makes a matrix of values to put in the pie charts. Honestly, the "what=#" is important and poorly documented. 1 worked here...

xx=c(-31.000000,  11.946449, -68.417016, -13.042360,  -6.943270,   7.266681,  14.236003,   0.000000, -49.256243,  -6.998651)
yy=c(-3.796280e-15,  1.199856e+01, -1.072157e-01, -1.788746e+01, -6.952995e+00, -7.215689e+00, -7.215689e+00,  0.000000e+00, -1.844581e+01,  7.052556e+00)
RP2=list(x=xx,y=yy)
replot(xy=RP2)

points(-62.5,0, cex=5, pch=15, col="white") #then used this to hash out a portion of that node for a break
points(-63.55,0, cex=5, pch="/", col="black") 
points(-61.55,0, cex=5, pch="/", col="black") 

text(0,0,"F9", col="white", font=2, cex=6)
text(-69,-4,"O24", col="black", font=2, cex=5)
text(-32,10,"F17", col="white", font=2, cex=6)
text(-6.5,10,"F7-9", col="black", font=2, cex=5)
text(12,15.5,"E86", col="black", font=2, cex=5)
text(-57.5,-18.5,"F6-17", col="black", font=2, cex=5)

segments(-72, 15, -66, 15, lwd=4)
text(-65.5, 15,"One substitution", col="black", font=2, cex=2.2, adj=0)



##other options:
#fq=attr(net,"freq") 
#length(seg.sites(x))
#haploFreq(x)
#unique(labels(x))


