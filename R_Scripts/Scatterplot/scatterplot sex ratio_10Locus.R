setwd("C:/Users/Zach/Desktop/R Stuff/Scatterplot")
library(graphics)
library(car)
library(Hmisc)

###Scatterplot for loci###
plot.new()

r = read.table("sex ratio props - 10Locus.txt", header = TRUE, row.names = NULL)
model = r$model
year = r$year
sex = r$sex
ratio = r$expected
up = r$Up
low = r$Low

scatterplot(ratio~year | model, xaxt="n",yaxt="n",ylab="",xlab="",smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,1), xlim=c(2010,2013), pch=c(15,16,17),
col=c("gray30", "gray70","black","black","red"), by.groups=TRUE, cex=0, legend.plot = FALSE)
axis(1, at = c(2011:2012), labels=c("2011","2012"), cex.axis = 1.25)
axis(2, at = NULL, cex.axis = 1.25)
mtext("Proportion of Individuals", side=2, line = 2.5, cex=1.5, las = 0)
mtext("Sampling Year", side=1, line = 2.75, cex=1.5, las = 0)
errbar(year, ratio, ratio + up, ratio - low, add = TRUE, cex = 2, col=c("gray80","gray80","gray80","gray80","gray55","gray55","gray55","gray55","black","black","black","black"), 
lwd=2, errbar.col = c("gray80","gray80","gray80","gray80","gray55","gray55","gray55","gray55","black","black","black","black"), pch = c(16,15,16,15))
legend(2012.3, 1, legend=c("Males - Expected","Males - Capwire","Males - Huggins","Females - Expected","Females - Capwire","Females - Huggins"), pch = c(16,16,16,15,15,15), col = c("gray80","gray55","black","gray80","gray55","black"),  pt.cex = 2, cex = 1.1)

?errbar()

