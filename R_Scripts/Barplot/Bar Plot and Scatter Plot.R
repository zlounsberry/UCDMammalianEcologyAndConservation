library(graphics)
plot.new()
par(mfrow=c(2,1),mar=c(5,7,5,2))

setwd("C:\\Users\\Zach\\Desktop\\R Stuff\\BoxPlot")
data = as.data.frame(read.table("All Hd Combined 10s.txt", header = T, row.names = NULL))
attach(data)
boxplot(Hd~ID, data=data, cex.axis = 1.25, cex.lab = 1.5, cex.main = 2, id.method="n", col = "gray50", xlab = "Adjusted Sample Size", ylab = "Hd Point Estimates", main = "Resampled Hd Distributions", range = 0) #Range 0 extends whiskers to outlier points
Hd = 0.357
CI95 = 0.0588 #1.96 * SD (which here is 0.03)
abline(h=Hd, lty=1, col = "black", lwd = 2)
abline(h=c(Hd+CI95, Hd-CI95), lty=2, col = 'black')
mtext("a)", side = 3, line = 2, adj = 0, cex = 2)

detach(data)

setwd("C:/Users/Zach/Desktop/R Stuff/Barplot")
Ranges = read.table("buffy resampling.txt", row.names = "Number",header = TRUE)
barplot(Ranges$Iterations, space = 0, axes = FALSE, axisnames = FALSE,
col="gray40", ylab = "Pop. with Overlapping CI", xlab = "Adjusted Sample Size",
cex.lab=1.5)
title("Resampling Iterations", line = 2.5, cex.main=2)
axis(1, at = c(0:12), labels=c("10","20","30","40","50","60","70","80","90","100","200","400",""), cex.axis = 1.25)
axis(2, at = NULL, xpd=TRUE, cex.axis = 1.25, las = 2)
mtext("b)", side = 3, line = 2, adj = 0, cex = 2)

