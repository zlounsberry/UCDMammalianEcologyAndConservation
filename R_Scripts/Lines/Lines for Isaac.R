setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Lines/")
library(graphics)
library(splines)
library(car)
rm(list=ls())

#####4
line1 = read.table("0w03.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
plot.new()
par(mar=c(6,6,5,5))
par(new=TRUE)
scatterplot(V2~x1, xaxt="n",yaxt="n",ylab="",xlab= expression("Wavenumbers" ~ (cm^{-1})), cex.lab=1.25,smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,0.1), xlim=rev(range(500:4000)), pch=c(15),
col="blue", cex=0, legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5w03.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(1500, 0.10, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Water at 0 hours ", cex.main = 1.5)
detach(line2)
rm(list=ls())

#####2
line1 = read.table("0w483.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
plot.new()
par(mar=c(6,6,5,5))
par(new=TRUE)
scatterplot(V2~x1, xaxt="n",yaxt="n",ylab="",xlab= expression("Wavenumbers" ~ (cm^{-1})), cex.lab=1.25,smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,0.1), xlim=rev(range(500:4000)), pch=c(15),
col="blue", cex=0, legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5w481.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(1500, 0.10, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Water at 48 hours", cex.main = 1.5)
detach(line2)
rm(list=ls())

##########1
line1 = read.table("0O03.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
plot.new()
par(mar=c(6,6,5,5))
par(new=TRUE)
scatterplot(V2~x1, xaxt="n",yaxt="n",ylab="",xlab= expression("Wavenumbers" ~ (cm^{-1})), cex.lab=1.25,smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,0.1), xlim=rev(range(500:4000)), pch=c(15),
col="blue", cex=0, legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5o01.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(1500, 0.10, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Orange juice at 0 hours", cex.main = 1.5)
detach(line2)
rm(list=ls())

#####4
line1 = read.table("0o481.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
plot.new()
par(mar=c(6,6,5,5))
par(new=TRUE)
scatterplot(V2~x1, xaxt="n",yaxt="n",ylab="",xlab= expression("Wavenumbers" ~ (cm^{-1})), cex.lab=1.25,smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,0.3), xlim=rev(range(500:4000)), pch=c(15),
col="blue", cex=0, legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5o483.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(1500, 0.30, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Orange juice at 48 hours", cex.main = 1.5)
detach(line2)
rm(list=ls())

#####3
line1 = read.table("0p01.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
plot.new()
par(mar=c(6,6,5,5))
par(new=TRUE)
scatterplot(V2~x1, xaxt="n",yaxt="n",ylab="",xlab= expression("Wavenumbers" ~ (cm^{-1})), cex.lab=1.25,smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,0.1), xlim=rev(range(500:4000)), pch=c(15),
col="blue", cex=0, legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5p03.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(1500, 0.10, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Pineapple juice at 0 hours", cex.main = 1.5)
detach(line2)
rm(list=ls())

#####
line1 = read.table("0p482.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
plot.new()
par(mar=c(6,6,5,5))
par(new=TRUE)
scatterplot(V2~x1, xaxt="n",yaxt="n",ylab="",xlab= expression("Wavenumbers" ~ (cm^{-1})), cex.lab=1.25,smooth=FALSE,
boxplot = FALSE, grid = FALSE, reg.line=FALSE, ylim=c(0,0.3), xlim=rev(range(500:4000)), pch=c(15),
col="blue", cex=0, legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5p483.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(1500, 0.30, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Pineapple juice at 48 hours", cex.main = 1.5)
detach(line2)
rm(list=ls())

#####All on one figure
plot.new()
par(mar=c(6,6,5,5), mfrow=c(2,3))

line1 = read.table("0w03.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000)
ylim = max(V2)+0.005
plot(V2~x1, type = "l", xaxt="n",yaxt="n",ylab="",xlab="", cex.lab=1.25,smooth=FALSE, ylim=c(0,0.1), xlim=rev(range(500:4000)), legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5w03.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add=T)
legend(2500, 0.1, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Water at 0 hours ", cex.main = 1.5)
detach(line2)
rm(list=ls())

##########1
line1 = read.table("0O03.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
ylim = max(V2)+0.005
plot(V2~x1, type = "l", xaxt="n",yaxt="n",ylab="",xlab="", cex.lab=1.25,smooth=FALSE, ylim=c(0,0.1), xlim=rev(range(500:4000)), legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5o01.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(2500, 0.1, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Orange juice at 0 hours", cex.main = 1.5)
detach(line2)
rm(list=ls())

#####3
line1 = read.table("0p01.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000)
ylim = max(V2)+0.005
plot(V2~x1, type = "l", xaxt="n",yaxt="n",ylab="",xlab="", cex.lab=1.25,smooth=FALSE, ylim=c(0,0.1), xlim=rev(range(500:4000)), legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5p03.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(2500, 0.1, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Pineapple juice at 0 hours", cex.main = 1.5)
detach(line2)
rm(list=ls())

#####2
line1 = read.table("0w483.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
ylim = max(V2)+0.005
plot(V2~x1, type = "l", xaxt="n",yaxt="n",ylab="",xlab="", cex.lab=1.25,smooth=FALSE, ylim=c(0,0.1), xlim=rev(range(500:4000)), legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5w481.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(2500, 0.1, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Water at 48 hours", cex.main = 1.5)
detach(line2)
rm(list=ls())


#####4
line1 = read.table("0o481.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
ylim = max(V2)+0.005
plot(V2~x1, type = "l", xaxt="n",yaxt="n",ylab="",xlab="", cex.lab=1.25,smooth=FALSE, ylim=c(0,0.3), xlim=rev(range(500:4000)), legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5o483.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(2500, 0.3, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Orange juice at 48 hours", cex.main = 1.5)
detach(line2)
rm(list=ls())

#####3
line1 = read.table("0p482.txt", header = FALSE, skip=1)
attach(line1)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
ylim = max(V2)+0.005
plot(V2~x1, type = "l", xaxt="n",yaxt="n",ylab="",xlab="", cex.lab=1.25,smooth=FALSE, ylim=c(0,0.3), xlim=rev(range(500:4000)), legend.plot = FALSE)
axis(1, at = NULL, cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
lines(predict(is,xvec),col="gray10", lwd = 2, lty = 1)
mtext("Absorption (ATR Units)", side=2, line = 3.5, cex=1.5, las = 0)
detach(line1)
line2 = read.table("5p483.txt", header = FALSE, skip=1)
attach(line2)
x1<-V1[rev(order(V1))] 
is = interpSpline(x1, V2)
xvec <- seq(min(x1),max(x1),length=2000) 
lines(x1, V2,col="gray", lwd = 2, lty = 5, add =T)
legend(2500, 0.3, legend=c("0g GHB","5g GHB"), lty=c(1,2), lwd=c(2,2), col=c("black", "gray"))
title(main = "Pineapple juice at 48 hours", cex.main = 1.5)
detach(line2)
rm(list=ls())

