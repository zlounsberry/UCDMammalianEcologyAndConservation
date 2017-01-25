setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Histograms")
library(graphics)
library(splines)
rm(list=ls())

####Two plots together! ############

bar2 = read.table("FrequencyMismatches - Replicates of All Individuals.txt", row.names="Mismatches", header = TRUE)
bar = read.table("FrequencyMismatches - Replicates of Same Individuals.txt", row.names="Mismatches", header = TRUE)
plot.new()
par(mfrow=c(2,1),mar=c(7,5,5,5))
Gray1 = rgb(0, 0, 0, 100, names = NULL, maxColorValue = 225)
Gray2 = rgb(0, 0, 0, 50, names = NULL, maxColorValue = 225)
barplot(bar$Frequency, space = 0, axes = FALSE, axisnames = FALSE, ylim=c(0,0.7),
col=Gray1, ylab = "Observed Frequency", xlab = "Locus Mismatches",cex.lab=1.5)
title("Locus Mismatches Among Replicate Genotypes", cex.main=1.5)
axis(1, at = 0.5:10.5, labels = 0:10, cex.axis = 1.25)
axis(2, at = c(0.0,0.2,0.4,0.6), xpd=TRUE, line=-1.75, cex.axis = 1.25, las = 2)
barplot(bar2$Frequency, space = 0, axes = FALSE, axisnames = FALSE,
col=Gray2, xaxt="n",yaxt="n",ylab="",xlab="", add=TRUE)
abline(v=4,col="gray30",lty="dotted", lwd=2)
legend(8.00, 0.580, legend=c("Same Pellet Group", "Random Pellet Group"), pt.cex=c(1.5, 1.5), pch=c(22, 22), pt.bg=c("gray60","gray85"), col=c("black"))


line = read.table("PID and Psib Binomial Probability_Inverted.txt", header = TRUE)
bar = read.table("PercentMismatches - same.txt", row.names="Mismatches", header = TRUE)
bar2 = read.table("FrequencyMismatches - Composites of All Individuals.txt", row.names="Mismatches", header = TRUE)
par(mar=c(7,5,5,5))
barplot(bar$Frequency, space = 0, axes = FALSE, axisnames = FALSE, ylim=c(0,0.5),
col=Gray1, ylab = "Observed Frequency", xlab = "Locus Mismatches",cex.lab=1.5)
title("", cex.main=0.01)
axis(1, at = (0.5:10.5), labels = 0:10, cex.axis = 1.25)
axis(2, at = c(0.0,0.1,0.2,0.3, 0.4, 0.5), xpd=TRUE, line=-1.75, cex.axis = 1.25, las = 2)
barplot(bar2$Frequency, space = 0, axes = FALSE, axisnames = FALSE,
col=Gray2, xaxt="n",yaxt="n",ylab="",xlab="", add=TRUE)
abline(v=4,col="gray30",lty="dotted", lwd=2)
par(new=TRUE)
ispsib = interpSpline(line$Matching, line$Psib)
ispID = interpSpline(line$Matching, line$PID)
xvec <- seq(min(line$Matching),max(line$Matching),length=200)  
lines(predict(ispsib,xvec),col="black", lwd = 2, lty = 1, add =T)
lines(predict(ispID,xvec),col="black", lwd = 2, lty = 2, add =T)
axis(4, at = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5),label=c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5),line=-1.7, cex.axis = 1.25, hadj=NA, las = 2)
mtext("Expected Frequency", side=4, line = 3.5, cex=1.5, las = 0)
legend(4.250, 0.480, legend=c("PID","PIDsib", "Same Individual", "Random Individual"), lty=c(2,1, NA, NA), lwd=c(2,2,1,1), pt.cex=c(NA, NA, 1.5, 1.5), pch=c(NA,NA, 22, 22), pt.bg=c(NA,NA,"gray60","gray85"), col=c("black"))
title(main = "Locus Mismatches Among Composite Genotypes", cex.main = 1.5)

##########Based on Replicate Genotypes############
bar2 = read.table("FrequencyMismatches - Replicates of All Individuals.txt", row.names="Mismatches", header = TRUE)
bar = read.table("FrequencyMismatches - Replicates of Same Individuals.txt", row.names="Mismatches", header = TRUE)
plot.new()
par(mar=c(7,5,5,5))
Gray1 = rgb(0, 0, 0, 100, names = NULL, maxColorValue = 225)
Gray2 = rgb(0, 0, 0, 50, names = NULL, maxColorValue = 225)

barplot(bar$Frequency, space = 0, axes = FALSE, axisnames = FALSE, ylim=c(0,0.7),
col=Gray1, ylab = "Frequency", xlab = "Locus Mismatches",cex.lab=1.5)
title("Locus Mismatches Among Replicate Genotypes", cex.main=1.5)
axis(1, at = 0:10, by =0.5, labels = 0:10, cex.axis = 1.25)
axis(2, at = c(0.0,0.2,0.4,0.6), xpd=TRUE, line=-1.75, cex.axis = 1.25, las = 2)
barplot(bar2$Frequency, space = 0, axes = FALSE, axisnames = FALSE,
col=Gray2, xaxt="n",yaxt="n",ylab="",xlab="", add=TRUE)
abline(v=3,col="gray30",lty="dotted", lwd=2)

text(0.5,0.6453,0.5953,col="gray50")
text(1.5,0.1946,0.1446,col="gray50")
text(2.5,0.1682,0.1182,col="gray50")
text(3.5,0.1417,0.0917,col="gray50")
text(4.5,0.0833,0.0333,col="gray50")
text(5.5,0.0639,0.0139,col="gray50")
text(6.5,0.0527,0.0027,col="gray50")
text(7.5,0.05,0,col="gray50")
text(8.5,0.05,0,col="gray50")
text(9.5,0.05,0,col="gray50")
text(10.5,0.05,0,col="gray50")
text(0.5,0.0513,0.0013,col="gray80")
text(1.5,0.0508,0.0008,col="gray80")
text(2.5,0.0506,0.0006,col="gray80")
text(3.5,0.0384,0.0014,col="gray80")
text(4.5,0.0576,0.0076,col="gray80")
text(5.5,0.0858,0.0298,col="gray80")
text(6.5,0.1334,0.0834,col="gray80")
text(7.5,0.2273,0.1773,col="gray80")
text(8.5,0.3259,0.2759,col="gray80")
text(9.5,0.3328,0.2828,col="gray80")
text(10.5,0.1885,0.1385,col="gray80")

#If you choose to add lines, based on composite genotypes...
line = read.table("PID and Psib Binomial Probability_inverted.txt", header = TRUE)
par(new=TRUE)
ispsib = interpSpline(line$Matching, line$Psib)
ispID = interpSpline(line$Matching, line$PID)
xvec <- seq(min(line$Matching),max(line$Matching),length=200)  
lines(predict(ispsib,xvec),col="black", lwd = 2, lty = 1, add =T)
lines(predict(ispID,xvec),col="black", lwd = 2, lty = 2, add =T)
axis(4, at = c(0.0, 0.2, 0.4, 0.6),label=c(0.0, 0.2, 0.4, 0.6),line=-1.7, cex.axis = 1.25, hadj=NA, las = 2)
mtext("Expected Frequency", side=4, line = 3.5, cex=1.5, las = 0)
legend(8.00, 0.580, legend=c("PID","PIDsib", "Replicates of Same Individual", "Replicates of Random Individual"), 
lty=c(2,1, NA, NA), lwd=c(2), pt.cex=c(NA, NA, 2, 2), pch=c(NA,NA, 22, 22), pt.bg=c(NA,NA,Gray1, Gray2), col=c("black"))

##########Based on Composite Genotypes, mismatches############
line = read.table("PID and Psib Binomial Probability_Inverted.txt", header = TRUE)
bar = read.table("PercentMismatches - same.txt", row.names="Mismatches", header = TRUE)
bar2 = read.table("FrequencyMismatches - Composites of All Individuals.txt", row.names="Mismatches", header = TRUE)
plot.new()
par(mar=c(7,5,5,5))
barplot(bar$Frequency, space = 0, axes = FALSE, axisnames = FALSE, ylim=c(0,0.5),
col="gray60", ylab = "Observed Frequency", xlab = "Mismatching Loci",cex.lab=1.5)
title("", cex.main=0.01)
axis(1, at = (0.5:10.5), labels = 0:10, cex.axis = 1.25)
axis(2, at = c(0.0,0.1,0.2,0.3, 0.4, 0.5), xpd=TRUE, line=-1.75, cex.axis = 1.25, las = 2)
barplot(bar2$Frequency, space = 0, axes = FALSE, axisnames = FALSE,
col="gray85", xaxt="n",yaxt="n",ylab="",xlab="", add=TRUE)
abline(v=4,col="gray30",lty="dotted", lwd=2)
par(new=TRUE)
legend(5.00, 0.480, legend=c("PID","PIDsib", "Same Individual", "Random Individual"), lty=c(2,1, NA, NA), lwd=c(2), pt.cex=c(NA, NA, 2, 2), pch=c(NA,NA, 22, 22), pt.bg=c(NA,NA,"gray60","gray85"), col=c("black"))
title(main = "Locus Mismatches vs. Probability of Identity", cex.main = 2)

##########Based on Composite Genotypes, matches############
line = read.table("PID and Psib Binomial Probability.txt", header = TRUE)
bar = read.table("PercentMismatches - same.txt", row.names="Mismatch", header = TRUE)
bar2 = read.table("PercentMismatches - diff.txt", row.names="Mismatch", header = TRUE)
plot.new()
par(mar=c(7,5,5,5))
barplot(bar$Percent, space = 0, axes = FALSE, axisnames = FALSE, ylim=c(0,0.5),
col="gray60", ylab = "Observed Frequency", xlab = "Matching Loci",cex.lab=1.5)
title("", cex.main=0.01)
axis(1, at = 0:10, labels = 0:10, cex.axis = 1.25)
axis(2, at = c(0.0,0.1,0.2,0.3, 0.4, 0.5), xpd=TRUE, line=-1.75, cex.axis = 1.25, las = 2)
barplot(bar2$Percent, space = 0, axes = FALSE, axisnames = FALSE,
col="gray85", xaxt="n",yaxt="n",ylab="",xlab="", add=TRUE)
abline(v=7,col="gray30",lty="dotted", lwd=2)
par(new=TRUE)
ispsib = interpSpline(line$Matching, line$Psib)
ispID = interpSpline(line$Matching, line$PID)
xvec <- seq(min(line$Matching),max(line$Matching),length=200)  
lines(predict(ispsib,xvec),col="black", lwd = 2, lty = 1, add =T)
lines(predict(ispID,xvec),col="black", lwd = 2, lty = 2, add =T)
axis(4, at = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5),label=c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5),line=-1.7, cex.axis = 1.25, hadj=NA, las = 2)
mtext("Expected Frequency", side=4, line = 3.5, cex=1.5, las = 0)
legend(3.00, 0.480, legend=c("PID","Psib", "Replicate Genotypes",
"Random Genotypes"), lty=c(2,1, NA, NA), lwd=c(2), pt.cex=c(NA, NA, 2, 2), pch=c(NA,NA, 22, 22), pt.bg=c(NA,NA,"gray60","gray85"), col=c("black"))
title(main = "Locus Matches vs. Probability of Identity", cex.main = 2)

