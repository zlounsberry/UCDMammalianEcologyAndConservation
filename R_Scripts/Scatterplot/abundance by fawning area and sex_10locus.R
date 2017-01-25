setwd("C:/Users/Zach/Desktop/R Stuff/Scatterplot")
library(graphics)
library(car)
library(Hmisc)

###Scatterplot for females###
plot.new()
par(mar=c(5,5,2,2))
p = read.table("EstimatesByFawningArea_Females.txt", header = TRUE, row.names = NULL)
attach(p)
scatterplot(Mean~Fawning | Year, xaxt="n",yaxt="n",ylab="Average Abundance (+/- SE)",xlab="Transect Name", cex.lab=1.25,smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,20), xlim=c(0,5), pch=c(23),
cex=0, legend.plot = FALSE)
axis(1, at = c(1:4), labels=c("CH/TF", "CR","CS","PM"), cex.axis = 1.25)
axis(2, at = NULL, cex.axis = 1.25)
errbar(Fawning, Mean, Mean + SE, Mean - SE, add = TRUE, col="black", lwd=2)
points(Mean~Fawning, pch=c(22), bg=c("dodgerblue1","dodgerblue1","dodgerblue1","dodgerblue1","forestgreen","forestgreen","forestgreen","forestgreen"), col=c("black"), cex = 2)
legend(4.2, 20, legend=c("2011", "2012"), pch = c(22), pt.bg = c("dodgerblue1","forestgreen"), pt.cex = 2, cex = 1.1)

###Scatterplot for Males###
plot.new()
par(mar=c(5,5,2,2))
p = read.table("EstimatesByFawningArea_Males.txt", header = TRUE, row.names = NULL)
attach(p)
scatterplot(Mean~Fawning | Year, xaxt="n",yaxt="n",ylab="Average Abundance (+/- SE)",xlab="Transect Name", cex.lab=1.25,smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,12), xlim=c(0,5), pch=c(23),
cex=0, legend.plot = FALSE)
axis(1, at = c(1:4), labels=c("CH/TF", "CR","CS","PM"), cex.axis = 1.25)
axis(2, at = NULL, cex.axis = 1.25)
errbar(Fawning, Mean, Mean + SE, Mean - SE, add = TRUE, col="black", lwd=2)
points(Mean~Fawning, pch=c(22), bg=c("dodgerblue1","dodgerblue1","dodgerblue1","dodgerblue1","forestgreen","forestgreen","forestgreen","forestgreen"), col=c("black"), cex = 2)
legend(4.2, 11, legend=c("2011", "2012"), pch = c(22), pt.bg = c("dodgerblue1","forestgreen"), pt.cex = 2, cex = 1.1)


###Scatterplot for bothsexes###
plot.new()
par(mar=c(5,5,2,2))
p = read.table("EstimatesByFawningArea_SexesCombined.txt", header = TRUE, row.names = NULL)
attach(p)
scatterplot(Mean~Fawning | Year, xaxt="n",yaxt="n",ylab="Average Abundance (+/- SE)",xlab="Transect Name", cex.lab=1.25,smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,30), xlim=c(0,5), pch=c(23),
cex=0, legend.plot = FALSE)
axis(1, at = c(1:4), labels=c("CH/TF", "CR","CS","PM"), cex.axis = 1.25)
axis(2, at = NULL, cex.axis = 1.25)
errbar(Fawning, Mean, Mean + SE, Mean - SE, add = TRUE, col="black", lwd=2)
points(Mean~Fawning, pch=c(22), bg=c("dodgerblue1","dodgerblue1","dodgerblue1","dodgerblue1","forestgreen","forestgreen","forestgreen","forestgreen"), col=c("black"), cex = 2)
legend(4.2, 30, legend=c("2011", "2012"), pch = c(22), pt.bg = c("dodgerblue1","forestgreen"), pt.cex = 2, cex = 1.1)


##Scatterplot for females###
plot.new()
par(mar=c(5,5,2,2))
p = read.table("EstimatesByFawningArea_NoyearsFemales.txt", header = TRUE, row.names = NULL)
attach(p)
scatterplot(Mean~Fawning, xaxt="n",yaxt="n",ylab="Average Abundance (+/- SE)",xlab="Transect Name", cex.lab=1.25,smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,18), xlim=c(0,5), pch=c(23), cex=0, legend.plot = FALSE)
axis(1, at = c(1:4), labels=c("CH/TF", "CR","CS","PM"), cex.axis = 1.25)
axis(2, at = NULL, cex.axis = 1.25)
errbar(Fawning, Mean, Mean + SE, Mean - SE, add = TRUE, col="black", lwd=2)
points(Mean~Fawning, pch=c(22), bg=c("dodgerblue1"), col=c("black"), cex = 2)
#legend(4.2, 20, legend=c("2011", "2012"), pch = c(22), pt.bg = c("dodgerblue1"), pt.cex = 2, cex = 1