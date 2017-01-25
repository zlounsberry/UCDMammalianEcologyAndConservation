setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/stackedbarggplot2")
library(reshape2)
library(ggplot2)
library(grid)
library(gridExtra)
#Some info on colors: http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/

NF <- read.table("SacValley_SPQ-TB_Q1.txt", header=TRUE)

NF.m <- melt(NF, id.var="ID")
#NF.m

tiff("Plot.tiff", width=2000, height=1000, res = 300)

plot = ggplot(NF.m, aes(x = ID, y = value, fill = variable, width = 1, ymax=1.0, ymin=0.0)) + 	#Just sets your x and y values and the fill determines groups. width = # is the width of the bar (from 0 to 1, the latter has no spacing)
	geom_bar(stat = "identity", colour = "white") + #colour="white" makes the sep. lines between bars white
	scale_fill_manual(values=c("yellow", "darkblue")) +  #Sets the colours (assigned by fill = variable above)
	coord_cartesian(ylim = c(-0.1,1)) + #Set your Y limit to be bound 0-1
	ylab("Probability of assignment\n") + #added newline char to increase space between label
	theme(axis.title.y = element_text(color="black", size=35, face="bold", vjust=0)) + 
	theme(axis.title.x = element_text(color="black", size=35, face="bold")) +
	theme(axis.text.y = element_text(color="black", size=20)) +
	annotation_custom(grob = linesGrob(gp=gpar(lwd=2.5)), xmin = 0.5, xmax = 115.5, ymin = 1.02, ymax = 1.02) +
	annotation_custom(grob = linesGrob(gp=gpar(lwd=2.5)), xmin = 115.5, xmax = 143.5, ymin = 1.01, ymax = 1.01) +
	xlab("Individuals") +
	theme(axis.text.x = element_blank(), plot.margin=unit(c(1,1,1,1),"cm"),text = element_text(size = 10)) +
	annotation_custom(grob=textGrob("Hybrids",gp=gpar(fontsize=35, col="black")), xmin=-1,xmax=-1,ymin=-0.05,ymax=-0.05) +
	annotation_custom(grob=textGrob("Non-Natives",gp=gpar(fontsize=35, col="black")), xmin=23,xmax=23,ymin=-0.05,ymax=-0.05) +
	annotation_custom(grob=textGrob("Natives",gp=gpar(fontsize=35, col="black")), xmin=78,xmax=78,ymin=-0.05,ymax=-0.05) +
	annotation_custom(grob=textGrob("Sacramento\nValley",gp=gpar(fontsize=35, col="black")), xmin=129,xmax=129,ymin=-0.08,ymax=-0.08) +
	annotation_custom(grob=textGrob("2007-2009",gp=gpar(fontsize=35, col="black")), xmin=70,xmax=70,ymin=1.06,ymax=1.06) +
	annotation_custom(grob=textGrob("2013-2015",gp=gpar(fontsize=35, col="black")), xmin=130,xmax=130,ymin=1.05,ymax=1.05) +
	theme(axis.ticks.x = element_blank()) +
	theme(panel.background = element_blank()) +
	geom_vline(xintercept = 6.5, lwd=1, colour="black", lty="longdash") +
	geom_vline(xintercept = 41.5, lwd=1, colour="black", lty="longdash") +
	geom_vline(xintercept = 115.5, lwd=1, colour="black", lty="longdash") +
	guides(fill=FALSE)
	

##Stolen from http://stackoverflow.com/questions/12409960/ggplot2-annotate-outside-of-plot	
gt <- ggplot_gtable(ggplot_build(plot))
	gt$layout$clip[gt$layout$name == "panel"] <- "off"
	grid.draw(gt)

dev.off()

ggsave("TomSophie_SVRF.tiff", width=40, height=20, dpi=200)
