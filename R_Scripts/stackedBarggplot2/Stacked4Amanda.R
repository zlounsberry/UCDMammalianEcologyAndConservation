library(reshape2)
library(ggplot2)


##Color reference:
##c("Fur Farm","North","Central","South") = c(mycol[2],mycol[3],mycol[1],mycol[4]) = c("firebrick1","dodgerblue1","black","darkgreen")

###########################
####Structure barplot######
###########################
setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/stackedbarggplot2")
NF <- read.table("testQ3.txt", header=TRUE)

NF.m <- melt(NF, id.var="ID")
ggplot(NF.m, aes(x = ID, y = value, fill = variable, width = 1, ymax=1.0, ymin=0.0)) + 	#Just sets your x and y values and the fill determines groups. width = # is the width of the bar (from 0 to 1, the latter has no spacing)
  geom_bar(stat = "identity", colour = "white") + #colour="white" makes the sep. lines between bars white
  scale_fill_manual(values=c("gray50", "black", "gray75","yellow")) +  #Sets the colours (assigned by fill = variable above)
  coord_cartesian(ylim = c(-0.1,1)) + #Set your Y limit to be bound 0-1
  ylab("Probability of assignment\n") + #added newline char to increase space between label
  theme(axis.title.y = element_text(color="black", size=45, face="bold", vjust=0)) + 
  theme(axis.title.x = element_text(color="black", size=40, face="bold")) +
  theme(axis.text.y = element_text(color="black", size=20)) +
  xlab("Individuals") +
  theme(axis.text.x = element_blank()) +
  #annotation_custom(grob=textGrob("North",gp=gpar(fontsize=32, col="dodgerblue1")), xmin=5,xmax=5,ymin=-0.05, ymax=-0.05) +
  theme(axis.ticks.x = element_blank()) +
  theme(panel.background = element_blank()) +
  #geom_vline(xintercept = 10.5, lwd=1, colour="black", lty="longdash") +
  guides(fill=FALSE)
