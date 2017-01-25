setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Scatterplot")
library(graphics)
library(car)
library(Hmisc)

###Scatterplot for loci###
plot.new()
par(mar=c(7,7,5,1))

r = read.table("sex ratio props - 10Locus Fixed_NoCapwire.txt", header = TRUE, row.names = NULL)
model = r$Model
year = r$Year
ratio = r$estimate
up = r$lower
low = r$upper

scatterplot(ratio~year | model, xaxt="n",yaxt="n",ylab="",xlab="",smooth=FALSE, boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,5), xlim=c(2010,2013), pch=c(21,21), 
bg=c("gray50","black"), col=c("gray50","black"), by.groups = TRUE, cex=2.25, legend.plot = FALSE)
axis(1, at = c(2011:2012), labels=c("2011","2012"), cex.axis = 2.5, tck=0.01)
axis(2, at = NULL, cex.axis = 2.5, tck=0.01)
mtext("Sex ratio (F:M)", side=2, line = 3.5, cex=3, las = 0)
mtext("Sampling year", side=1, line = 3.75, cex=3, las = 0)
errbar(year, ratio, ratio + up, ratio - low, add = TRUE, cex = 3, lwd=3, errbar.col = c("gray50","gray50","black","black"), pch = c(21), bg=c("gray50","gray50","black","black"))
legend(2011.4, 5, legend=c("No. individuals","Abundance estimates"), pch = c(21), col = "black", pt.bg = c("gray50","black"), pt.cex = 3, cex = 1.5)


