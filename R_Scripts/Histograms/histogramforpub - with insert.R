setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Histograms")
library(graphics)
library(splines)
library(png)
rm(list=ls())
Gray1 = rgb(0, 0, 0, 100, names = NULL, maxColorValue = 225)
Gray2 = rgb(0, 0, 0, 50, names = NULL, maxColorValue = 225)

####Two plots together! ############

bar2 = read.table("FrequencyMatches_10Locus.txt", row.names="match", header = TRUE)
bar = read.table("FrequencyMatches_10Locus - Insert.txt", row.names="match", header = TRUE)
plot.new()
#par(mar=c(3,3,3,4)) #For Insert
par(mar=c(8,12,2,1)) #For plot
#Insert:
barplot(bar$freq, space = 0.1, axes = FALSE, axisnames = FALSE, ylim=c(0,750), xlim=c(-0.25,6),
col="black", xaxt="n",yaxt="n",ylab="",xlab="")
axis(1, at = c(0.6,1.7,2.8,3.9,5,6.1), labels = c(5,6,7,8,9,10), cex.axis = 2, xpd=TRUE) #at = 0.5:6.5, 
axis(2, at = c(0, 250, 500, 750), xpd=TRUE, line=-1.75, cex.axis = 2, las = 2)
abline(v=3.35,col="black",lty="dotted", lwd=2)
#Save this as 10LocusInsert.png
#Plot:
barplot(bar2$freq, space = 0.1, axes = FALSE, axisnames = FALSE, ylim=c(0,120000), xlim=c(-0.01,12),
col="black", ylab = "Observed frequency", xlab = "",cex.lab=4, line=7)
#title("Locus Matches Among Replicate Genotypes", cex.main=2)
axis(1, at = c(0.6,1.7,2.8,3.9,5,6.1,7.2,8.3,9.4, 10.5, 11.6), labels = 0:10, cex.axis = 2, xpd=TRUE)
axis(2, at = c(0, 20000, 40000, 60000, 80000, 100000, 120000), labels=prettyNum(c(0, 20000, 40000, 60000, 80000, 100000, 120000), big.mark=","), xpd=TRUE, line=-1.75, cex.axis = 2, las = 2)
insert = readPNG("10LocusInsert.png")
rasterImage(insert, 5.25, 40000, 11, 120000)
mtext("No. matching loci",1, cex = 4, line =4.5)
segments(8.855, 0, 8.855, 20000, lwd = 2, xpd = TRUE, lty = "dotted")
segments(5.25, 40000, 11, 40000, lwd = 2, xpd = TRUE)
segments(5.25, 120000, 11, 120000, lwd = 2, xpd = TRUE)
segments(5.25, 40000, 5.25, 120000, lwd = 2, xpd = TRUE)
segments(11, 40000, 11, 120000, lwd = 2, xpd = TRUE)
segments(5.6, 0, 5.25, 40000, lwd = 1.5)
segments(12.1, 0, 11, 40000, lwd = 1.5, xpd = TRUE)
