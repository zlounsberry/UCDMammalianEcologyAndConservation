setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/scatterplot")
library(graphics)
library(car)
library(splines)
library(Hmisc)

plot.new()
par(mfrow=c(2,2))

p = read.table("Coverage11April2014AncientSamples.txt", header = TRUE, row.names=NULL)

Site = p$Site
Avg = p$Avg
up = p$Upper
low = p$Lower
cov = p$Covered

plot(Site, Avg, ylim=c(0,10), xlim=c(10,16500),xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = c(10:16500), labels=NULL, cex.axis = 1)
axis(2, at = c(0:10), labels=NULL, cex.axis = 1)
mtext("Average Coverage (Read Depth)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
title("Coverage 11April2014 AncientSamples", cex.main = 1.5)
lines(up, col="black", lwd=2)
lines(low, col="black", lwd=2)
segments(x0=Site,x1=Site,y0=low,y1=up, col="dodgerblue1")
lines(Avg, y=NULL, col="black", cex = 1, lwd=2)
abline(h=3, lwd=1, lty=2)


plot(Site, cov, ylim=c(0,89), xlim=c(10,16500), xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = NULL, labels=NULL, cex.axis = 1)
axis(2, at = NULL, labels=NULL, cex.axis = 1)
title("Histogram 11April2014 AncientSamples", cex.main = 1.5)
mtext("Number of individuals covered > 2X (out of 89)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
segments(x0=Site,x=Site,y0=0,y1=cov, col=c("black"))


##############

p = read.table("Coverage30April2014AncientSamples.txt", header = TRUE, row.names=NULL)

Site = p$Site
Avg = p$Avg
up = p$Upper
low = p$Lower
cov = p$Covered

plot(Site, Avg, ylim=c(0,13), xlim=c(10,16500),xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = c(10:16500), labels=NULL, cex.axis = 1)
axis(2, at = c(0:13), labels=NULL, cex.axis = 1)
mtext("Average Coverage (Read Depth)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
title("Coverage 30April2014 AncientSamples", cex.main = 1.5)
lines(up, col="black", lwd=2)
lines(low, col="black", lwd=2)
segments(x0=Site,x1=Site,y0=low,y1=up, col="firebrick1")
lines(Avg, y=NULL, col="black", cex = 1, lwd=2)
abline(h=3, lwd=1, lty=2)

plot(Site, cov, ylim=c(0,87), xlim=c(10,16500), xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = NULL, labels=NULL, cex.axis = 1)
axis(2, at = NULL, labels=NULL, cex.axis = 1)
title("Histogram 30April2014 AncientSamples", cex.main = 1.5)
mtext("Number of individuals covered > 2X (out of 87)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
segments(x0=Site,x=Site,y0=0,y1=cov, col=c("black"))

##############

p = read.table("Coverage11June2014AncientSamples.txt", header = TRUE, row.names=NULL)

Site = p$Site
Avg = p$Avg
up = p$Upper
low = p$Lower
cov = p$Covered

plot(Site, Avg, ylim=c(0,35), xlim=c(10,16500),xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = c(10:16500), labels=NULL, cex.axis = 1)
axis(2, at = c(0:35), labels=NULL, cex.axis = 1)
mtext("Average Coverage (Read Depth)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
title("Coverage 11June2014 AncientSamples", cex.main = 1.5)
lines(up, col="black", lwd=2)
lines(low, col="black", lwd=2)
segments(x0=Site,x1=Site,y0=low,y1=up, col="chartreuse3")
lines(Avg, y=NULL, col="black", cex = 1, lwd=2)
abline(h=3, lwd=1, lty=2)

plot(Site, cov, ylim=c(0,46), xlim=c(10,16500), xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = NULL, labels=NULL, cex.axis = 1)
axis(2, at = NULL, labels=NULL, cex.axis = 1)
title("Histogram 11June2014 AncientSamples", cex.main = 1.5)
mtext("Number of individuals covered > 2X (out of 46)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
segments(x0=Site,x=Site,y0=0,y1=cov, col=c("black"))

##############

p = read.table("Coverage30June2014AncientSamples.txt", header = TRUE, row.names=NULL)

Site = p$Site
Avg = p$Avg
up = p$Upper
low = p$Lower
cov = p$Covered

plot(Site, Avg, ylim=c(0,10), xlim=c(10,16500),xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = c(10:16500), labels=NULL, cex.axis = 1)
axis(2, at = c(0:10), labels=NULL, cex.axis = 1)
mtext("Average Coverage (Read Depth)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
title("Coverage 30June2014 AncientSamples", cex.main = 1.5)
lines(up, col="black", lwd=2)
lines(low, col="black", lwd=2)
segments(x0=Site,x1=Site,y0=low,y1=up, col="gray86")
lines(Avg, y=NULL, col="black", cex = 1, lwd=2)
abline(h=3, lwd=1, lty=2)

plot(Site, cov, ylim=c(0,66), xlim=c(10,16500), xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = NULL, labels=NULL, cex.axis = 1)
axis(2, at = NULL, labels=NULL, cex.axis = 1)
title("Histogram 30June2014 AncientSamples", cex.main = 1.5)
mtext("Number of individuals covered > 2X (out of 66)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
segments(x0=Site,x=Site,y0=0,y1=cov, col=c("black"))

#############MODERN STUFF#############################

p = read.table("Coverage11April2014ModernDogs.txt", header = TRUE, row.names=NULL)

Site = p$Site
Avg = p$Avg
up = p$Upper
low = p$Lower
cov = p$Covered

plot(Site, Avg, ylim=c(0,350), xlim=c(10,16500),xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = c(10:16500), labels=NULL, cex.axis = 1)
axis(2, at = c(0:350), labels=NULL, cex.axis = 1)
mtext("Average Coverage (Read Depth)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
title("Coverage 11April2014 Modern Dogs, etc.", cex.main = 1.5)
lines(up, col="black", lwd=2)
lines(low, col="black", lwd=2)
segments(x0=Site,x1=Site,y0=low,y1=up, col="yellow2")
lines(Avg, y=NULL, col="black", cex = 1, lwd=2)
abline(h=3, lwd=1, lty=2)

plot(Site, cov, ylim=c(0,44), xlim=c(10,16500), xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = NULL, labels=NULL, cex.axis = 1)
axis(2, at = NULL, labels=NULL, cex.axis = 1)
title("Histogram 11April2014 Modern Dogs, etc.", cex.main = 1.5)
mtext("Number of individuals covered > 2X (out of 44)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
segments(x0=Site,x=Site,y0=0,y1=cov, col=c("black"))

###################

p = read.table("Coverage11April2014ModernRedFox.txt", header = TRUE, row.names=NULL)

Site = p$Site
Avg = p$Avg
up = p$Upper
low = p$Lower
cov = p$Covered

plot(Site, Avg, ylim=c(0,500), xlim=c(10,16500),xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = c(10:16500), labels=NULL, cex.axis = 1)
axis(2, at = c(0:500), labels=NULL, cex.axis = 1)
mtext("Average Coverage (Read Depth)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
title("Coverage 11April2014 Modern RedFox", cex.main = 1.5)
lines(up, col="black", lwd=2)
lines(low, col="black", lwd=2)
segments(x0=Site,x1=Site,y0=low,y1=up, col="firebrick1")
lines(Avg, y=NULL, col="black", cex = 1, lwd=2)
abline(h=3, lwd=1, lty=2)

plot(Site, cov, ylim=c(0,18), xlim=c(10,16500), xaxt="n",yaxt="n",ylab="",xlab="", cex=0)
axis(1, at = NULL, labels=NULL, cex.axis = 1)
axis(2, at = NULL, labels=NULL, cex.axis = 1)
title("Histogram 11April2014 Modern RedFox", cex.main = 1.5)
mtext("Number of individuals covered > 2X (out of 18)", side=2, line = 2.5, cex=1, las = 0)
mtext("Site", side=1, line = 2.75, cex=1, las = 0)
segments(x0=Site,x=Site,y0=0,y1=cov, col=c("black"))