setwd("C:/Users/Zach/Desktop/R Stuff/Histograms")
library(graphics)
rm(list=ls())

################FINAL GRAPH SCRIPT!!##################
line = read.table("PID and Psib Binomial Probability.txt", header = TRUE)
bar = read.table("PercentMismatches - same.txt", row.names="Mismatch", header = TRUE)
bar2 = read.table("PercentMismatches - diff.txt", row.names="Mismatch", header = TRUE)
plot.new()
par(mar=c(7,5,5,5))

barplot(bar$Percent, space = 0, axes = FALSE, axisnames = FALSE,
col="yellow", ylab = "Observed Frequency", xlab = "Matching Loci",cex.lab=1.5)
title("", cex.main=0.01)
axis(1, at = 0:10, labels = 0:10, cex.axis = 1.25)
axis(2, at = c(0.0,0.11,0.22,0.33, 0.44), xpd=TRUE, cex.axis = 1.25, las = 2)
barplot(bar2$Percent, space = 0, axes = FALSE, axisnames = FALSE,
col="red2", xaxt="n",yaxt="n",ylab="",xlab="", add=TRUE)
abline(v=7,col="dodgerblue",lty="dotted", lwd=2)
par(new=TRUE)
matplot(line$Matching, line[, c("Psib","PID")], type="l", 
lty=c(1,2), lwd=2, col =c("black"), xaxt="n",yaxt="n",ylab="",xlab="")
axis(4, at = c(0.0, 0.1, 0.2, 0.3, 0.39), cex.axis = 1.25, hadj=NA, las = 2)
mtext("Expected Frequency", side=4, line = 3.5, cex=1.5, las = 0)
legend(3.00, 0.380, legend=c("Psib","PID", "Resampled Deer",
"All Genotypes"), col=c("black", "black", "yellow", "red2"),
lty=c(1,2, NA, NA), lwd=c(2), pt.cex=c(NA, NA, 2, 2), pch=c(NA,NA, 15, 15))

##########Changes############
plot.new()
par(mar=c(5,5,1,5))

barplot(bar$Percent, space = 0, axes = FALSE, axisnames = FALSE, ylim=c(0,0.5),
col="forestgreen", ylab = "Observed Frequency", xlab = "Matching Loci",cex.lab=1.5)
title("", cex.main=0.01)
axis(1, at = 0:10, labels = 0:10, cex.axis = 1.25)
axis(2, at = c(0.0,0.1,0.2,0.3, 0.4, 0.5), xpd=TRUE, line=-1.75, cex.axis = 1.25, las = 2)
barplot(bar2$Percent, space = 0, axes = FALSE, axisnames = FALSE,
col="tan4", xaxt="n",yaxt="n",ylab="",xlab="", add=TRUE)
abline(v=7,col="dodgerblue",lty="dotted", lwd=2)
par(new=TRUE)
matplot(line$Matching, line[, c("Psib","PID")], type="l", 
lty=c(1,2), offset=0.5, lwd=2, col =c("black"), xaxt="n",yaxt="n",ylab="",xlab="", add=T)
axis(4, at = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5),label=c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5),line=-1.7, cex.axis = 1.25, hadj=NA, las = 2)
mtext("Expected Frequency", side=4, line = 3.5, cex=1.5, las = 0)
legend(3.00, 0.480, legend=c("Psib","PID", "Resampled Deer",
"All Genotypes"), col=c("black", "black", "forestgreen", "tan4"),
lty=c(1,2, NA, NA), lwd=c(2), pt.cex=c(NA, NA, 2, 2), pch=c(NA,NA, 15, 15))


########Older iterations of the above script########
barplot(bar$Percent, space = 0, axes = FALSE, axisnames = FALSE,
col="cornflowerblue", ylab = "Frequency", xlab = "Matching Loci",cex.lab=1.5)
title("", cex.main=0.01)
axis(1, at = 0:10, labels = 0:10, cex.axis = 1.25)
axis(2, at = c(0.0,0.11,0.22,0.33), xpd=TRUE, cex.axis = 1.25, las = 2)
abline(v=7,col="firebrick1",lty="dotted", lwd=2)
par(new=TRUE)
matplot(line$Matching, line[, c("Psib","PID")], type="l", 
lty=c(1,2), lwd=2, col =c("black"), xaxt="n",yaxt="n",ylab="",xlab="")
axis(4, at = c(0.0, 0.1, 0.2, 0.3, 0.39), cex.axis = 1.25, hadj=NA, las = 2)
mtext("Probability", side=4, line = 3.5, cex=1.5, las = 0)
legend(8.00, 0.380, legend=c("Psib","PID"), col=c("black"),
lty=c(1,2), lwd=c(2))





####Other crap I did to get to this point.......########
plot.new()
Hist(x$V1, scale="percent", freq=FALSE, breaks=12, main="Pairwise Comparisons",
ylab="Frequency", xlab = "Number of Loci Matched Between Pairs",
labels=TRUE, xaxt="n", col="purple")
axis(side=1, at=c(1:11))
axis(side=1, at=c(1:10))
abline(v=6,col="gray",lty=5, lwd=2)
abline(v=8,col="black",lty=5, lwd=2)

y = read.table("histo2.txt")
plot.new()
par(mai=c(1.02, 0.82, 0.82, 0.42))
Hist(y$V1, scale="percent", freq=FALSE, breaks=10, main="Pairwise Comparisons",
ylab="Frequency", xlab = "Number of Loci Matched Between Pairs",
labels=TRUE, xaxt="n", col="purple")
axis(side=1, at=c(1:10))
axis(side=1, at=c(1:10))
abline(v=6,col="gray",lty=5, lwd=2)
abline(v=8,col="black",lty=5, lwd=2)
?hist()

#Plotting the two together
set.seed(42)
Hist1 = hist(x$V1, freq=TRUE, breaks=10)
Hist2 = hist(y$V1, freq=FALSE, breaks=10)

lab1 = as.character(c(ADD THE PERCENTAGES OR FREQ HERE)
plot(Hist1, col=rgb(0,0,1,1/4), xlim=c(0,11), 
main="Pairwise Comparisons", xlab = "Matching Loci", ylab ="Frequency",
labels=lab1)
axis(side=1, at=c(1:10))
lab2 = as.character(c(ADD THE PERCENTAGES OR FREQ HERE)

plot(Hist2, col=rgb(1,0,0,1/4), xlim=c(0,10), add=T,
labels=lab2)

?hist

?text
?axis
##LINE GRAPHS##
line = read.table("PID and Psib.txt", header = TRUE)
?matplot
par(new=TRUE)
matplot(line$Mismatches, line[, c("PID","PSIB")], type="l", 
lty=c(1,2), lwd=3, ylab="Probability", col =c("black"),
xaxt="n",yaxt="n",xlab="")
axis(4)
axis(2, at = NULL, cex.axis = 1.25)
mtext("Probability",side=4,line=3)