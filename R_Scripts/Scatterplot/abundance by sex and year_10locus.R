setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Scatterplot")
library(graphics)
library(car)
library(Hmisc)
###Scatterplot for loci###
plot.new()
par(mar=c(7,10,4,2))
r = read.table("Abundance Means by year and sex.txt", header = TRUE, row.names = NULL)
year = r$year
sex = r$sex
estimate = r$estimate
low  = r$low
up = r$up

scatterplot(estimate~year | sex, xaxt="n",yaxt="n",ylab="",xlab="",smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,16), xlim=c(2010,2013), pch=c(21,21), bg = c("black","gray50"),
col=c("black","gray50"), by.groups=TRUE, cex=0, legend.plot = FALSE)
axis(1, at = c(2011:2012), labels=c("2011","2012"), cex.axis = 2.5, tck=0.01)
axis(2, at = NULL,  cex.axis = 3, tck=0.01)
mtext(expression(paste(hat(N), ' ('%+-% '95% CI)')), side=2, line = 4.5, cex=3, las = 0)
mtext("Sampling year", side=1, line = 3.5, cex=3, las = 0)
errbar(year, estimate, estimate + up, estimate - low, add = TRUE, cex = 3, col=c("black"), 
lwd=3, errbar.col = c("black","black","gray50","gray50"), pch = c(21), bg=c("black","black","gray50","gray50"))
legend(2011.95, 16.5, legend=c("Females", "Males"), pch = c(21,21), col = c("black","black"), pt.bg = c("black","gray50"), pt.cex = 3, cex = 2)

r1 = read.table("Abundance Means by year.txt", header = TRUE, row.names = NULL)
year = r1$year
estimate = r1$estimate
se = r1$CI

scatterplot(estimate~year, xaxt="n",yaxt="n",ylab="",xlab="",smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,25), xlim=c(2010,2013), pch=c(16),
col=c("black"), cex=0, legend.plot = FALSE)
axis(1, at = c(2011:2012), labels=c("2011","2012"), cex.axis = 1.25)
axis(2, at = NULL, cex.axis = 1.25)
mtext("Abundance Estimate (N-hat)", side=2, line = 2.5, cex=1.5, las = 0)
mtext("Sampling Year", side=1, line = 2.75, cex=1.5, las = 0)
errbar(year, estimate, estimate + se, estimate - se, add = TRUE, cex = 2, col=c("black"), 
lwd=2, errbar.col = c("black"), pch = c(16))
#legend(2012.7, 16, legend=c("N-hat"), pch = c(16), col = c("black"),  pt.cex = 2, cex = 1.1)

?errbar()

