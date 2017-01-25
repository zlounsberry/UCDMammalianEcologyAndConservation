library(reshape2)
library(ggplot2)
library(gridExtra)

setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/VCFStatisticFigures")
Elk = read.table("TuleElkStats_SheepGenome.txt", header=TRUE)
Elk.noTot = Elk[-1,]
Elk.Tot = Elk[1,]

#R loops are absolutely idiotic. Here is a basic one for making basic boring figures

for(NUMBER in 1:26){
p = ggplot(Elk.noTot, aes(x = CHR, y = as.name(paste("chr",NUMBER, sep="")))) +
	geom_bar(stat = "identity", fill="black") +
	labs(title = paste("Chromosome ",NUMBER)) + 
	xlab("Sample ID") +
	ylab("Heterozygous Sites") +
	theme(panel.background = element_blank(), panel.grid.major.x = element_blank(),panel.grid.major.y = element_line(colour = "grey40"),axis.ticks.x = element_blank())

ggsave(file = paste("Chromosome ",NUMBER,".png"), plot = p)
}

