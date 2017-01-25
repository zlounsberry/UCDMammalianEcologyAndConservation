setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/stackedbarggplot2")
library(reshape2)
library(ggplot2)
#Some info on colors: http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/

DF <- read.table(text="Rank F1     F2     F3
1    500    250    50
2    400    350    50
3    300    150    350
4    200    400    200", header=TRUE)

DF.m <- melt(DF, id.var="Rank")
DF.m

p = ggplot(DF.m, aes(x = Rank, y = value, fill = variable, width = .98)) + 	#Just sets your x and y values and the fill determines groups. width = # is the width of the bar (from 0 to 1, the latter has no spacing)
	geom_bar(stat = "identity", colour = "black") + # uses the melted data to build the bar chart and colour = "color" refers to the border color of the bar charts. Can change colour = "black" to colour = NA to get rid of borders altogether. Could be good for structure plots
	scale_fill_manual(values=c("black", "red2", "yellow")) #This determines your color scheme manually (here just the different reds) I like this option
	#scale_fill_brewer(palette = "Pastel2") #This uses RColorBrewer to set a color scheme based on their available schemes
	
p = p + scale_x_continuous(name="Ranks And Stuff") + 
	scale_y_continuous(name="Values and Stuff") + #Label your axes
	theme(axis.title.x = element_text(family = "sans", face="italic", colour="#990000", size=20, vjust = .5), 
	axis.text.x  = element_text(angle = 45, vjust=0, size=16)) + # Use angle = (some value from 0-180) to rotate x axis text
	theme(axis.title.y = element_text(family = "sans", face="italic", colour="#990000", size=20, vjust = .5),
     axis.text.y  = element_text(angle = 45, vjust=0, size=16)) # Use angle = (some value from 0-180) to rotate y axis text

#For the stuff below, do "p = p + OPTIONS" if you want to combine multiple of them, and make the last one just p + OPTIONS and it will plot.
#p = p + theme(panel.background = element_rect(fill = "black",colour = "white"), panel.grid.minor = element_blank(), panel.grid.major = element_blank(), plot.background = element_rect(fill = "transparent",colour = NA))
p = p + theme(panel.background = element_rect(fill = "white", colour = "black"), panel.grid.minor = element_blank(), panel.grid.major = element_blank(), plot.background = element_rect(fill = "transparent",colour = NA))
#p = p + scale_x_discrete(breaks=c(DF[,1]), labels=c(DF[,1])) #For relabeling. Needs debugging...
#p + coord_flip() #flips the chart on its side
p
