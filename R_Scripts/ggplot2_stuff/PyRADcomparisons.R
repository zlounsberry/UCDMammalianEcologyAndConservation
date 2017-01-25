#Here's a decent intro to quick plots ggplot2: http://blog.echen.me/2012/01/17/quick-introduction-to-ggplot2/
#Here is a less user-friendly (but much more indepth) guide to ggplot2: http://docs.ggplot2.org/current/

setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/ggplot2 stuff")
library(ggplot2)
library(plyr)
rm(list=ls()) #I just like to have this handy. Clears all objects...

AF1009 = read.table("AF-1009.txt", sep = "\t", header = T) 
AF0538 = read.table("AF-0538.txt", sep = "\t", header = T) 
AF0218 = read.table("AF-0218.txt", sep = "\t", header = T) 
AF0601 = read.table("AF-0601-90.txt", sep = "\t", header = T) 
AF0443 = read.table("AF-0443.txt", sep = "\t", header = T) 
AF0796 = read.table("AF-0796.txt", sep = "\t", header = T) 
All = read.table("Allpyrad.txt", sep = "\t", header = T) 
shapes=c(21, 21, 22, 22)
colors=c("dodgerblue1","firebrick1","dodgerblue2","firebrick2")
#This makes the 090's blue and the 096's red

pdf("pyrad.pdf", width=16, height=10)

#This will plot the values against our range in different colors
ggplot(data = AF1009, aes(y=poly, x=taxon, by=Percent, color=Percent, shape=Percent)) + 
	geom_point(aes(colour=factor(Percent), fill = factor(Percent)), size = 10) +
	scale_alpha(guide = 'none') +
	xlab("Dataset") +
	ylab("Step 5 poly") +
	scale_shape_manual(values=shapes, guide=F)+ 
	scale_color_manual(values=c("black","black","black","black"), guide=F) +
#	scale_fill_manual(values=c(full90='blue', full96='pink', sub90='blue', sub96='pink'), guide=F) +
	scale_fill_manual(values=colors, guide=F) +
	theme(axis.text=element_text(size=16), axis.title=element_text(size=20,face="bold")) +
	theme(legend.key = element_rect(fill = "white",colour = "white"), legend.text = element_text(face="bold")) +
	ggtitle("Sample AF1009") +
	theme(panel.grid.major = element_line("black"),panel.background = element_blank(), plot.title = element_text(size =40))


ggplot(data = AF0218, aes(y=poly, x=taxon, by=Percent, color=Percent, shape=Percent)) + 
	geom_point(aes(colour=factor(Percent), fill = factor(Percent)), size = 10) +
	scale_alpha(guide = 'none') +
	xlab("Dataset") +
	ylab("Step 5 poly") +
	scale_shape_manual(values=shapes, guide=F)+ 
	scale_color_manual(values=c("black","black","black","black"), guide=F) +
#	scale_fill_manual(values=c(full90='blue', full96='pink', sub90='blue', sub96='pink'), guide=F) +
	scale_fill_manual(values=colors, guide=F) +
	theme(axis.text=element_text(size=16), axis.title=element_text(size=20,face="bold")) +
	theme(legend.key = element_rect(fill = "white",colour = "white"), legend.text = element_text(face="bold")) +
	ggtitle("Sample AF0218") +
	theme(panel.grid.major = element_line("black"),panel.background = element_blank(), plot.title = element_text(size =40))

ggplot(data = AF0796, aes(y=poly, x=taxon, by=Percent, color=Percent, shape=Percent)) + 
	geom_point(aes(colour=factor(Percent), fill = factor(Percent)), size = 10) +
	scale_alpha(guide = 'none') +
	xlab("Dataset") +
	ylab("Step 5 poly") +
	scale_shape_manual(values=shapes, guide=F)+ 
	scale_color_manual(values=c("black","black","black","black"), guide=F) +
#	scale_fill_manual(values=c(full90='blue', full96='pink', sub90='blue', sub96='pink'), guide=F) +
	scale_fill_manual(values=colors, guide=F) +
	theme(axis.text=element_text(size=16), axis.title=element_text(size=20,face="bold")) +
	theme(legend.key = element_rect(fill = "white",colour = "white"), legend.text = element_text(face="bold")) +
	ggtitle("Sample AF0796") +
	theme(panel.grid.major = element_line("black"),panel.background = element_blank(), plot.title = element_text(size =40))


ggplot(data = AF0443, aes(y=poly, x=taxon, by=Percent, color=Percent, shape=Percent)) + 
	geom_point(aes(colour=factor(Percent), fill = factor(Percent)), size = 10) +
	scale_alpha(guide = 'none') +
	xlab("Dataset") +
	ylab("Step 5 poly") +
	scale_shape_manual(values=shapes, guide=F)+ 
	scale_color_manual(values=c("black","black","black","black"), guide=F) +
#	scale_fill_manual(values=c(full90='blue', full96='pink', sub90='blue', sub96='pink'), guide=F) +
	scale_fill_manual(values=colors, guide=F) +
	theme(axis.text=element_text(size=16), axis.title=element_text(size=20,face="bold")) +
	theme(legend.key = element_rect(fill = "white",colour = "white"), legend.text = element_text(face="bold")) +
	ggtitle("Sample AF0443") +
	theme(panel.grid.major = element_line("black"),panel.background = element_blank(), plot.title = element_text(size =40))


ggplot(data = AF0538, aes(y=poly, x=taxon, by=Percent, color=Percent, shape=Percent)) + 
	geom_point(aes(colour=factor(Percent), fill = factor(Percent)), size = 10) +
	scale_alpha(guide = 'none') +
	xlab("Dataset") +
	ylab("Step 5 poly") +
	scale_shape_manual(values=shapes, guide=F)+ 
	scale_color_manual(values=c("black","black","black","black"), guide=F) +
#	scale_fill_manual(values=c(full90='blue', full96='pink', sub90='blue', sub96='pink'), guide=F) +
	scale_fill_manual(values=colors, guide=F) +
	theme(axis.text=element_text(size=16), axis.title=element_text(size=20,face="bold")) +
	theme(legend.key = element_rect(fill = "white",colour = "white"), legend.text = element_text(face="bold")) +
	ggtitle("Sample AF0538") +
	theme(panel.grid.major = element_line("black"),panel.background = element_blank(), plot.title = element_text(size =40))

#Also here's everyone!
ggplot(data = All, aes(y=poly, x=nloci, by=Percent, color=Percent, shape=Percent)) + 
	geom_point(aes(colour=factor(Percent), fill = factor(Percent)), size = 4) +
	scale_alpha(guide = 'none') +
	xlab("Number of Loci") +
	ylab("Step 5 poly") +
	scale_shape_manual(values=c(22,22), guide=F)+ 
	scale_color_manual(values=c("black","black","black","black"), guide=F) +
#	scale_fill_manual(values=colors, guide=F) +
	scale_fill_manual(values=c(full90='dodgerblue1', full96='firebrick1'), guide=F) +
	theme(axis.text=element_text(size=16), axis.title=element_text(size=20,face="bold")) +
	theme(legend.key = element_rect(fill = "white",colour = "white"), legend.text = element_text(face="bold")) +
	ggtitle("All samples (n=48)") +
	theme(panel.grid.major = element_line("black"),panel.background = element_blank(), plot.title = element_text(size =40))




#This one only ran at 90.
ggplot(data = AF0601, aes(y=poly, x=taxon, by=Percent, color=Percent, shape=Percent)) + 
	geom_point(aes(colour=factor(Percent), fill = factor(Percent)), size = 10) +
	scale_alpha(guide = 'none') +
	xlab("Dataset") +
	ylab("Step 5 poly") +
	scale_shape_manual(values=shapes, guide=F)+ 
	scale_color_manual(values=c("black","black","black","black"), guide=F) +
#	scale_fill_manual(values=c(full90='blue', full96='pink', sub90='blue', sub96='pink'), guide=F) +
	scale_fill_manual(values=colors, guide=F) +
	theme(axis.text=element_text(size=16), axis.title=element_text(size=20,face="bold")) +
	theme(legend.key = element_rect(fill = "white",colour = "white"), legend.text = element_text(face="bold")) +
	ggtitle("Sample AF-0601") +
	theme(panel.grid.major = element_line("black"),panel.background = element_blank(), plot.title = element_text(size =40))


