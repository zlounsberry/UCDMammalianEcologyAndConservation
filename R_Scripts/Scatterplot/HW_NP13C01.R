setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Scatterplot")
library(graphics)
library(car)
library(Hmisc)

###Scatterplot for loci###
plot.new()
par(mar=c(5,5,5,5), xpd=T)
r = read.table("NP13C01.txt", header = F, row.names = NULL)
ravg=read.table("NP13C01_avg.txt", header = F, row.names = NULL)
attach(r)
names=c("omentum",
"M-LN",
"spleen",
"ascites",
"liver",
"feces",
"lung ",
"heart",
"pop-LN",
"kidney",
"WBC")
n = c(1:10)
scatterplot(V3~V1 | V4, xaxt="n", yaxt="n",ylab="Log10FIPV/g Tissue", cex.lab=2,xlab="Tissue",smooth=FALSE, boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0.7,10), xlim=c(0,12), pch=c(19,19,19,19,19,19,19,19,19,19,19),
col=c("black","black","black","black","black","black","black","black","black","black","black","black"), cex=1, legend.plot = FALSE)
axis(1, at=c(1:11), labels=names, lwd=1, cex.axis=1.5)
axis(2, at=NULL, labels=NULL, lwd=1, cex.axis=1.5, font=2)
rect(-1,10.2,13,11, border="white",col="white")
rect(12.4,-1,13,11, border="white",col="white")
#title("FIPV Loads in Tissue Types")

points(ravg$V1, ravg$V2, pch="-", col="black", cex=6)


