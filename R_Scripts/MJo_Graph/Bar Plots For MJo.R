setwd("C:/Users/Zach/Desktop/R Stuff/MJo Graph")
library(graphics)

###Bar Plot for loci###
Ranges = read.table("AvgLoci_Range.txt", row.names = "Range",header = TRUE)
plot.new()
barplot(Ranges$Loci, space = 0, axes = FALSE, axisnames = FALSE,
col="dodgerblue1", ylab = "Mean No. Loci", xlab = "Concentration (pg/µL)",
cex.lab=1.5)
title("Loci Amplified at Various Concentrations", line = 2.5, cex.main=2)
axis(1, at = c(0:6), labels=c("0","100","200", "300","400","500+", ""), cex.axis = 1.25)
axis(2, at = c(0:10), xpd=TRUE, cex.axis = 1.25, las = 2)

###Scatterplot for loci###
plot.new()
Concentration = read.table("AvgLoci_Conc.txt", header = TRUE)
C = Concentration$Conc
L = Concentration$Loci
SE = Concentration$SE

scatterplot(L~C, xaxt="n",yaxt="n",ylab="",xlab="", smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,11), pch=19,
col="dodgerblue1", cex=2)
axis(2, at = c(0:11), labels=c(0:11), cex.axis = 1.25)
axis(1, at = NULL)
mtext("Mean No. Loci", side=2, line = 2.5, cex=1.5, las = 0)
mtext("Concentration(pg/µL)", side=1, line = 2.75, cex=1.5, las = 0)
errbar(C, L, L + SE, L - SE, xlab = "Concentration (pg/µL)", ylab = "Mean
 No. Loci", add = TRUE, col=c("dodgerblue1"), lwd=2)
title("Loci Amplified at Various Concentrations", cex.main = 2)


###Another Scatterplot####
Errors = read.table("Error Rate Replicates.txt", header = TRUE)
Rep = Errors$No.Replicates
Rate = Errors$ErrorRate

with(Errors, plot(Rep, Rate, log = "y", xaxt="n", cex = 1.85, 
yaxt="n",ylab="",xlab="", lwd=3, col="dodgerblue1", type = "b", pch = 19, lty = 2))

axis(2, at = c(0.0001, 0.001, 0.01, 0.1, 1), labels = NULL, cex.axis = 1.25)
axis(1, at = c(0:4), labels = NULL, cex.axis= 1.25)
mtext("Error Rate", side=2, line = 2.5, cex=1.5, las = 0)
mtext("No. Replicates", side=1, line = 2.75, cex=1.5, las = 0)
title("Error Rate Per Replicate", cex.main = 2)