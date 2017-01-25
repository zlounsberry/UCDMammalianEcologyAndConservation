setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/stackedbarggplot2")
library(reshape2)
library(ggplot2)
library(grid)
library(gridExtra)
#Some info on colors: http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/

NF <- read.table("Newfoundland_Q.txt", header=TRUE)

NF.m <- melt(NF, id.var="ID")
#NF.m


ggplot(NF.m, aes(x = ID, y = value, fill = variable, width = 1, ymax=1.0, ymin=0.0)) + 	#Just sets your x and y values and the fill determines groups. width = # is the width of the bar (from 0 to 1, the latter has no spacing)
	geom_bar(stat = "identity", colour = "white") + #colour="white" makes the sep. lines between bars white
	scale_fill_manual(values=c("gray50", "black")) +  #Sets the colours (assigned by fill = variable above)
	coord_cartesian(ylim = c(-0.1,1)) + #Set your Y limit to be bound 0-1
	ylab("Probability of assignment\n") + #added newline char to increase space between label
	theme(axis.title.y = element_text(color="black", size=35, face="bold", vjust=0)) + 
	theme(axis.title.x = element_text(color="black", size=35, face="bold")) +
	theme(axis.text.y = element_text(color="black", size=20)) +
	xlab("Individuals") +
	theme(axis.text.x = element_blank()) +
	annotation_custom(grob=textGrob("wild",gp=gpar(fontsize=30, col="black")), xmin=20,xmax=20,ymin=-0.05,ymax=-0.05) +
	annotation_custom(grob=textGrob("fur farm",gp=gpar(fontsize=30, col="black")), xmin=80,xmax=80,ymin=-0.05,ymax=-0.05) +
	theme(axis.ticks.x = element_blank()) +
	theme(panel.background = element_blank()) +
	geom_vline(xintercept = 43.5, lwd=1, colour="black", lty="longdash") +
	guides(fill=FALSE)
	
	
