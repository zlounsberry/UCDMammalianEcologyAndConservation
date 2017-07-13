###Bar Plot for loci###
par(xpd=NA, mar=c(1,8,9,0.1))

##Clean this up, would you? -Me to me.

##Offset - 10 Locus
#2011
Data = read.table("BarPlotData.txt", row.names = "Class", header = TRUE) #extracted
Data2 = read.table("BarPlotData2.txt", row.names = "Class", header = TRUE) #Yielded DNA
Data3 = read.table("BarPlotData3.txt", row.names = "Class", header = TRUE) # Unique Individuals
Data4 = read.table("BarPlotData4.txt", row.names = "Class", header = TRUE) #Yielded full genotypes

barplot(Data$Number, axes = FALSE, axisnames = FALSE, col="gray90", ylab = "No. pellet groups or individuals", width = 1, cex.lab=3, xlab = "", line = 4.5, legend.text = T)
text (0.67, 460, labels = Data$Number, col="black", cex=3.5)
barplot(Data2$Number, axes = FALSE, axisnames = FALSE, width = 0.9, space = 0.223, col="gray60", ylab = "", xlab = "", add=T)
text (0.645, 275, labels = c("298 (62%)"), col = "black", cex=3.5)
barplot(Data4$Number, axes = FALSE, axisnames = FALSE, col="gray30",space = 0.252, width=0.8, ylab = "", xlab = "",add=T)
text (0.60, 225, labels = c("252 (53%)"), col = "white", cex = 3.5)
barplot(Data3$Number, axes = FALSE, axisnames = FALSE, col="gray0",space = 0.272, width=0.75, ylab = "", xlab = "",add=T)
text (0.56, 125, labels = c("149 (32%)"), col = "white", cex =3.5)
text (0, 555, labels = c("A)"), col = "black", cex = 4, font = 1)
axis(1, at = c(0:1.2), labels=c("",""), tick=FALSE, cex.axis = 3)
axis(2, at = c(0,100,200,300,400,500), xpd=TRUE, cex.axis = 2.55)
#legend(1.28, 450, legend=c("Extracted", "Successfully Genotyped", "Full Genotypes","Unique Genotypes"), pch=c(22,22,22,22), bg = "white", pt.bg=c("gray90","gray60","gray30", "gray0"), col=c("black"),pt.cex=c(1.25))
