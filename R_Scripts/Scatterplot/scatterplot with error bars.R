setwd("C:/Users/Zach/Desktop/R Stuff/Scatterplot")
library(graphics)
library(car)
library(Hmisc)

###Scatterplot for loci###
plot.new()

p = read.table("capture probability both years - 10Locus.txt", header = TRUE, row.names = NULL)
Year = p$Year
sex = p$Sex
p0 = p$p
up = p$lower
low = p$upper

scatterplot(p0~Year | sex, xaxt="n",yaxt="n",ylab="",xlab="",smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,0.6), xlim=c(2010,2013), pch=c(15,16),
col=c("black", "black"), by.groups=TRUE, cex=2, legend.plot = FALSE)
axis(1, at = c(2011:2012), labels=c("2011","2012"), cex.axis = 1.25)
axis(2, at = NULL, cex.axis = 1.25)
mtext("Capture Probability (p)", side=2, line = 2.5, cex=1.5, las = 0)
mtext("Sampling Year", side=1, line = 2.75, cex=1.5, las = 0)
errbar(Year, p0, p0 + up, p0 + low, add = TRUE, col="black", lwd=2)
legend(2012.2, 0.5, legend=c("Females", "Males"), pch = c(15, 16), pt.cex = 2, cex = 1.1)


