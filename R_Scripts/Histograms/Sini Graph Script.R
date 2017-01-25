setwd("C:/Users/Zach/Desktop/R Stuff/Histograms/Sini")
library(graphics)
rm(list=ls())

################FINAL GRAPH SCRIPT!!##################
bar = read.table("Error.txt", row.names = "Loci", header = TRUE)
bar2 = read.table("Mismatch.txt", row.names="Loci", header = TRUE)
plot.new()
par(mar=c(7,5,10,5))

barplot(bar$Error, space = 0, axes = FALSE, axisnames = FALSE,
col="forestgreen", ylab = "Observed Frequency", xlab = "Matching Loci",cex.lab=1.5)
title("Sini's Cool Graph", line = 5, cex.main=1.2)
axis(1, at = c(-0.5:13.5), labels = c("",0:12,""), cex.axis = 1.25)
barplot(bar2$Mismatch, space = 0, axes = FALSE, axisnames = FALSE,
col="dodgerblue1", xaxt="n",yaxt="n",ylab="",xlab="", add=TRUE)
axis(2, at = c(0,0.2, 0.4, 0.6, 0.8, 1), cex.axis = 1.25, hadj=NA, xpd = T, las = 2)
legend(10.00, 0.780, legend=c("Error", "PID"), col=c("black", "black"),
pt.cex=c(2,2), pch=c(22, 22), pt.bg=c("forestgreen","dodgerblue1"))
