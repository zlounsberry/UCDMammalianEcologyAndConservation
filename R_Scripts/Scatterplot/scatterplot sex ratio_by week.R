setwd("C:/Users/Zach/Desktop/R Stuff/Scatterplot")
library(graphics)
library(car)
library(Hmisc)

###Scatterplot for 2011###
plot.new()

r = read.table("2011_SexRatioByWeek.txt", header = TRUE, row.names = NULL)

scatterplot(estimate~Week, xaxt="n",yaxt="n",ylab="",xlab="",smooth=FALSE, boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,10), xlim=c(0.5,2.5), pch=c(16,16,16),
col=c("gray45", "gray75","black"), cex=2, legend.plot = FALSE, data = r)
axis(1, at = c(1:2), labels=c("Week 1","Week 2"), cex.axis = 1.25)
axis(2, at = NULL, cex.axis = 1.25)
mtext("Sex Ratio (Female:Male)", side=2, line = 2.5, cex=1.5, las = 0)
mtext("Sampling Week", side=1, line = 2.75, cex=1.5, las = 0)
mtext("2011", side=3, line = 1.5, cex=3.5, las = 0)
errbar(r$Week, r$estimate, r$estimate + r$up, r$estimate - r$low, add = TRUE, cex = 0, lwd=2, errbar.col = c("black"), pch = c(16))
#legend(2012.3, 10, legend=c("Expected","Capwire","Huggins"), pch = c(16), col = c("gray75","gray45","black"),  pt.cex = 2, cex = 1.1)

###Scatterplot for 2012###
plot.new()

r = read.table("2012_SexRatioByWeek.txt", header = TRUE, row.names = NULL)

scatterplot(estimate~Week, xaxt="n",yaxt="n",ylab="",xlab="",smooth=FALSE, boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,6), xlim=c(0.5,4.5), pch=c(16),
col=c("black"), cex=2, legend.plot = FALSE, data = r)
axis(1, at = c(1:4), labels=c("Week 1","Week 2","Week 3","Week 4"), cex.axis = 1.25)
axis(2, at = NULL, cex.axis = 1.25)
mtext("Sex Ratio (Female:Male)", side=2, line = 2.5, cex=1.5, las = 0)
mtext("Sampling Week", side=1, line = 2.75, cex=1.5, las = 0)
mtext("2012", side=3, line = 1.5, cex=3.5, las = 0)
errbar(r$Week, r$estimate, r$estimate + r$up, r$estimate - r$low, add = TRUE, cex = 0, lwd=2, errbar.col = c("black"), pch = c(16))
#legend(2012.3, 10, legend=c("Expected","Capwire","Huggins"), pch = c(16), col = c("gray75","gray45","black"),  pt.cex = 2, cex = 1.1)

