setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Scatterplot")
library(graphics)
library(car)
library(Hmisc)

###Scatterplot for loci###
plot.new()
r
r = read.table("Deer Extraction Success By Extractor2.txt", header = TRUE, row.names = NULL)
attach(r)
detach(r)
n = c(1:8)
Name
Prop
Low
Up
Name = as.character(Name)
Name
scatterplot(Prop~n, xaxt="n",yaxt="n",ylab="",xlab="",smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,1), xlim=c(0,9), pch=c(15),
col=c("gray30"), cex=1, legend.plot = FALSE)
axis(1, at = c(1:8), labels=c(Name), cex.axis = 1.25)
axis(2, at = NULL, cex.axis = 1.25)
mtext("Proportion of successful extractions", side=2, line = 2.5, cex=1.5, las = 0)
mtext("Extractor", side=1, line = 2.75, cex=1.5, las = 0)
errbar(n, Prop, Prop + Up, Prop - Low, add = TRUE, cex = 2, col="black", lwd=2)
title("Proportion of Extractions Successful", cex.main = 1.5)
abline(h = 0.64, lty = 2)
?abline()
Prop
text(1, 0.95, "241")
text(2, 0.95, "93")
text(3, 0.95, "18")
text(4, 0.95, "70")
text(5, 0.95, "41")
text(6, 0.95, "85")
text(7, 0.95, "321")
text(8, 0.95, "567")


