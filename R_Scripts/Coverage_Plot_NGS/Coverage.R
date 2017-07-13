library(graphics)
library(car)
library(splines)
library(Hmisc)

png("Coverage_Plot.png",height=10, width=20, unit="in", res=100)
p = read.table("file.txt", header = TRUE, row.names=NULL)

Position = p$Position
Avg = p$Avg_Depth
up = p$Upper_SE
low = p$Lower_SE
cov = p$Number_Covered_Samples
Number_Sites = nrow(p)

plot(Position, Avg, ylim=c(-0.5,max(up)+0.5), xlim=c(0,Number_Sites),xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = c(0,Number_Sites), labels=NULL, cex.axis = 1)
axis(2, at = c(-0.5,max(up)+0.5), labels=NULL, cex.axis = 1)
mtext("Average Coverage (Read Depth)", side=2, line = 2.5, cex=1, las = 0)
mtext("Position", side=1, line = 2.75, cex=1, las = 0)
title("Coverage", cex.main = 1.5)
lines(up, col="black", lwd=2)
lines(low, col="black", lwd=2)
segments(x0=Position,x1=Position,y0=low,y1=up, col="dodgerblue1")
lines(Avg, y=NULL, col="black", cex = 1, lwd=2)
abline(h=median(Avg), lwd=1, lty=2)

dev.off()
