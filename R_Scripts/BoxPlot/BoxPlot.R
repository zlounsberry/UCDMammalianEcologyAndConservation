setwd("V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\BoxPlot")

library(graphics)

plot.new()
par(mfrow=c(1,2))
data = as.data.frame(read.table("All Hd Combined_CR.txt", header = T, row.names = NULL))
boxplot(data$Hd~data$ID, data=data, id.method="n", ylim=c(0:1), col = "gray50", xlab = "Adjusted Sample Size", ylab = "Hd", main = "Resampled Hd Distributions - Control region", range = 0) #Range 0 extends whiskers to outlier points
Hd1 = 0.729
CI951 = 0.0392 #1.96 * SD (which here is 0.02)
abline(h=Hd1, lty=1, col = "black", lwd = 2)
abline(h=c(Hd1+CI951, Hd1-CI951), lty=2, col = 'black')
mtext("(a)", 3, adj=-0.1, line = 1.5, cex = 2)


data2 = as.data.frame(read.table("All Hd Combined_CytB.txt", header = T, row.names = NULL))
boxplot(data2$Hd~data2$ID, data=data, id.method="n", col = "gray50", ylim=c(0:1), xlab = "Adjusted Sample Size", ylab = "Hd", main = "Resampled Hd Distributions - Cytochrome b", range = 0) #Range 0 extends whiskers to outlier points
Hd2 = 0.357
CI952 = 0.0588 #1.96 * SD (which here is 0.03)
abline(h=Hd2, lty=1, col = "black", lwd = 2)
abline(h=c(Hd2+CI952, Hd2-CI952), lty=2, col = 'black')
mtext("(b)", 3, adj=-0.1, line = 1.5, cex = 2)

#Scatterplot for proportions!
library(car)
library(Hmisc)
data2 = as.data.frame(read.table("Prop Of Samplings Fall Into 95CI.txt", header = T, row.names = NULL))

plot.new()
ID = data2$ID
Points = data2$Proportion
Low = data2$Lower
Up = data2$Upper
Low
Up
Low = Points - Low
Up = Up - Points
y = seq(0,1,by=0.1)

scatterplot(Points~ID, smooth=FALSE, boxplot = FALSE, grid = FALSE, ylim = c(0:1), xlab = "Adjusted Sample Size", ylab = "Hd", reg.line=FALSE, 
pch=19, bg = "dodgerblue1", col = "dodgerblue", cex=2)

errbar(ID, Points, Points + Up, Points - Low, add = TRUE, col=c("dodgerblue1"), lwd=2)


##Other Scatterplot
data2 = as.data.frame(read.table("Prop Of Samplings Fall Into 95CI.txt", header = T, row.names = NULL))

plot.new()
ID = data2$ID
Points = data2$Proportion
Low = data2$Lower
Up = data2$Upper
Low
Up
Low = Points - Low
Up = Up - Points
y = seq(0,1,by=0.1)

scatterplot(Points~ID, smooth=FALSE, boxplot = FALSE, grid = FALSE, ylim = c(0:1), xlab = "Adjusted Sample Size", ylab = "Hd", reg.line=FALSE, 
pch=19, bg = "dodgerblue1", col = "dodgerblue", cex=2)

errbar(ID, Points, Points + Up, Points - Low, add = TRUE, col=c("dodgerblue1"), lwd=2)


