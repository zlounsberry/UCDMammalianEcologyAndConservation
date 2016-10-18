##Many figures were put together here and modified in Inkscape (https://inkscape.org/en/)##

################################
####### 	FIGURE 1: MAP #########
################################
setwd("PATH") #Where PATH is where your data live
library(ggplot2)
library(rgdal)
library(sp)
library(raster)

##Learned this from tutorials posted here: http://rpsychologist.com/working-with-shapefiles-projections-and-world-maps-in-ggplot and shapefiles grabbed from links therein
wmap = readOGR(dsn="PATH/ne_110m_land.shp", layer="ne_110m_land") #Land layer
wmap_df = fortify(wmap) 
bbox = readOGR("PATH/ne_110m_wgs84_bounding_box.shp", layer="ne_110m_wgs84_bounding_box") #bounding box, this is the earth shape
bbox_df = fortify(bbox)
countries = readOGR(dsn="PATH/ne_110m_admin_0_countries.shp", layer="ne_110m_admin_0_countries") #As you can guess, these contain the countries
countries_df = fortify(countries)
Canada = readOGR("PATH/Canada.shp", layer="Canada") #source https://www.arcgis.com/home/item.html?id=dcbcdf86939548af81efbd2d732336db
Canada = spTransform(Canada, CRS("+proj=longlat +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
Canada_df = fortify(Canada)
grat = readOGR("PATH/ne_110m_graticules_30.shp", layer="ne_110m_graticules_30") #not sure what this is either, it was part of the tutorial
grat_df = fortify(grat)


##tranform to winkel tripel projection
wmap_wintri = spTransform(wmap, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
wmap_wintri_df <- fortify(wmap_wintri)  
bbox_wintri = spTransform(bbox, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
bbox_wintri_df <- fortify(bbox_wintri)
countries_wintri = spTransform(countries, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
countries_wintri_df <- fortify(countries_wintri)
Canada_wintri = spTransform(Canada, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
Canada_wintri_df <- fortify(Canada_wintri)
grat_wintri = spTransform(grat, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
grat_wintri_df <- fortify(grat_wintri)


#Define some themes (basically everything is blank).
theme_opts <- list(theme(panel.grid.minor = element_blank(),
                         panel.grid.major = element_blank(),
                         panel.background = element_blank(),
                         plot.background = element_rect(fill="white"),
                         panel.border = element_blank(),
                         axis.line = element_blank(),
                         axis.text.x = element_blank(),
                         plot.margin=unit(c(0,0,0,0),"mm"),
                         axis.text.y = element_blank(),
                         axis.ticks = element_blank(),
                         axis.title.x = element_blank(),
                         axis.title.y = element_blank(),
					   plot.title = element_text(size=42)))

#PlottedbySize
AllPops=read.table("allpopscombined2.txt", row.names=NULL, header=T) #Location data (see metadata)
AllPops=SpatialPointsDataFrame(coords=AllPops[,c(2,3)], data=AllPops)
crs(AllPops) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
mapdata<-data.frame(AllPops)
AllPops_df= fortify(mapdata)
AllPops_wintri=spTransform(AllPops, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
mapdata<-data.frame(AllPops_wintri)
AllPops_wintri = fortify(mapdata)

p1 = ggplot(bbox_wintri_df, aes(long,lat, group=group, lwd=1),lwd=1) + #plot the bounding box
  geom_polygon(fill="white", alpha=0.1) + #Make the ocean from the bounding box
  geom_polygon(data=countries_wintri_df, aes(long,lat, group=group, fill=hole), lwd=1, col="black", fill="gray85") + #make a polygon of just the countries  
  geom_polygon(fill="transparent",colour="black") +
  theme_opts + #Apply our themes from above
  geom_point(data=AllPops_wintri, aes(long.1,lat.1, group=NULL, size=count, fill=OriginalPopID),alpha=0.9,fill=c("firebrick1","darkgreen",rep("black",2),"dodgerblue1",rep("dodgerblue1",8)), pch=c(21,21,rep(21,2),21,rep(22,8))) + 
  scale_size_continuous("points",range=c(2,7)) +
  geom_curve(data=NULL, aes(x = -3952166, y = 5281870, xend = -4752166, yend = 5281870,lwd=1), curvature = -0.05) +
  geom_curve(data=NULL, aes(x = -3952166, y = 5281870, xend = -3952166, yend = 6951870,lwd=1),curvature = -0.05) +
  geom_curve(data=NULL, aes(x = -4752166, y = 6951870, xend = -3952166, yend = 6951870,lwd=1),curvature = 0.05) +
  geom_curve(data=NULL, aes(x = -4752166, y = 6951870, xend = -4752166, yend = 5281870,lwd=1),curvature = 0.05) +
  theme(legend.position="none") +
  coord_quickmap(xlim=c(-10005539,-3600000),ylim=c(3000000,9328438)) + 
  coord_fixed(xlim=c(-10005539,-3600000),ylim=c(3000000,9328438))

ggsave("Map_World.png", plot = p1, width=15,height=15,units="in", dpi=300)

p2 = ggplot(data=Canada_wintri_df, aes(long,lat, group=group),lwd=2) + #plot the bounding box
  theme_opts + #Apply our themes from above
  geom_polygon(data=bbox_wintri_df,fill="white", alpha=0.1) + #Make the ocean from the bounding box
  geom_polygon(aes(long,lat, group=group, fill=hole), col="black", fill="gray85") + #make a polygon of just the countries  
  geom_point(data=AllPops_wintri, aes(long.1,lat.1, group=NULL, size=count, fill=OriginalPopID),alpha=0.95,fill=c("firebrick1","darkgreen",rep("black",2),rep("dodgerblue1",9)), pch=c(21,21,rep(21,2),21,rep(22,8))) + 
  scale_size_continuous("points",range=c(5,15)) +
  theme(legend.position="none") +
  coord_quickmap(xlim=c(-4752166, -3952166),ylim=c(5301870,6801870)) + 
  coord_fixed(xlim=c(-4752166, -3952166),ylim=c(5301870,6801870)) 

ggsave("Map_Site.png", plot = p2, width=8,height=15,units="in", dpi=300, scale=0.5) #scale = 0.5 for the points to be larger (also makes lines wider)

#Pulled these two into inkscape and cleaned up/attached (including a legend from PCA below, with numbers added)
#legend("topright",pch=c(16,16,15,16,16), cex=2, text.font=2,col=transp(c("firebrick1","dodgerblue1","dodgerblue1","black","darkgreen"),0.8), leg=c("fur farm (93)","modern north wild (11)", "historical north wild (12)","central wild (41)","south wild (27)"),pt.cex=4) #This legend was given samples sizes in parentheses and then clipped and added to Fig. 1 in Inkscape


###############################################
########  FIGURE 2: Haplotype Network   #######
###############################################

#The fig 2 script is a bit of a mess...

setwd("PATH")
library(pegas) 
library(dplyr)

#IMPORTANT NOTE:
	#ALL '-' CHARACTERS WERE REPLACED WITH N'S IN THIS FILE. THIS MEANS THAT F85 AND F79 WERE IDENTICAL. THIS CAUSED THE PACKAGE TO LUMP THEM TOGETHER
	#THE FILE USED HERE HAS HAD THOSE N'S REPLACED WITH T'S. THIS MAKES EVERYTHING DISPLAY CORRECTLY.

x = read.dna(file="20160815_AllSamplesAligned4HapNetwork_WithHistorical.fas", format="fasta") #made from the metadata file
h = pegas::haplotype(x, labels=c("F-17","F-274","F-275","F6-17","F7-9","F-9","E-86","F-85","O-25","F-79")) # need to add F79 onto here.
net <- haploNet(h)
dev.new(width=80, height=40)
plot(net, size=c(40,5,3,4,	1,15,2,6,2,1), pie=haploFreq(x, what=1, haplo=h), bg=c("gray20","firebrick1","dodgerblue1","dodgerblue1","darkgreen"), scale.ratio=6, lwd=4, adj=(y=0), labels=F, cex=5, show.mutation=0, threshold=0)

	#size=attr(net,"freq") will make each node the size of its respective frequency. In this case, it makes it too big... So I did that "size=c(40,...2) to scale better
	#pie=haploFreq(x, what=1, haplo=h) makes a matrix of values to put in the pie charts. Honestly, the "what=#" is important and poorly documented. 1 worked here...

#replot() #use this with the plot open to click nodes and replot them. It will print new x and y coords into the terminal for you to make into an object for replot() below.

xx=c(-33.500000,-56.152476, -9.320420,-63.945882,9.367828,0.000000,-12.497016,13.264601,-78.028226,13.264601)
yy=c(-4.102431e-15,1.645799e+01,-1.110764e+01,-1.773442e+01,-1.040403e+01,0.000000e+00,1.770491e+01,8.947086e+00,-5.654795e-02, 1.770491e+01)
RP2=list(x=xx,y=yy)
replot(xy=RP2)

points(-66.5,0, cex=5, pch=15, col="white") #then used this to hash out a portion of that node for a break
points(-67.55,0, cex=5, pch="/", col="black") 
points(-65.55,0, cex=5, pch="/", col="black") 

text(0,3,"F-9", col="white", font=2, cex=6)
text(-78.02822,-3,"O-24", col="black", font=2, cex=5)
text(-9.320420,-15,"F-275", col="black", font=2, cex=5)
text(-56.152476,22,"F-274", col="black", font=2, cex=5)
text(-33.50,10,"F-17", col="white", font=2, cex=7)
text(14,4,"F-85", col="black", font=2, cex=5)
text(13.264601,21,"F-79", col="black", font=2, cex=5)
text(9.367828,-13,"F7-9", col="black", font=2, cex=5)
text(-12.497016,21,"E-86", col="black", font=2, cex=5)
text(-63.945882,-21.5,"F6-17", col="black", font=2, cex=5)

#And since I cannot seem to add texture to these colors, remade figure to add texture to Historical samples in Inkscape (https://inkscape.org/en/)
#For the remade figure, I did not include this text, etc. However, I left it in for this script so the figure is more or less reproducable)


#####################################
####FIGURE 3: Structure barplot######
#####################################
library(ggplot2)
library(car)
library(reshape2)
library(Hmisc)
library(grid)

setwd("PATH") #Where PATH is where your data live
theme_set(theme_grey()) #I need to have this in here or it gives me a debug error ...

##All samples, 14 loci, modern and historical fig. 3A
NF = read.table("Newfoundland_stru_Q_withHistorical_Final.txt", header=TRUE) #This is the output Q values from a K = 2 run of STRUCTURE in tab-delimited format (14 loci, including historical).
NF.m = melt(NF, id.var="ID") #Melt it for ggplot. Package: reshape2
stru = ggplot(NF.m, aes(x = ID, y = value, fill = variable, width = 1, ymax=1.0, ymin=0.0)) + 	#Just sets your x and y values and the fill determines groups. width = # is the width of the bar (from 0 to 1, the latter has no spacing)
	geom_bar(stat = "identity", colour = "white") + #colour="white" makes the sep. lines between bars white
	scale_fill_manual(values=c("goldenrod1", "firebrick1")) +  #Sets the colours (assigned by fill = variable above)
	coord_cartesian(ylim = c(-0.1,1)) + #Set your Y limit to be bound 0-1
	ylab("Probability of assignment\n") + #added newline char to increase space between label
	theme(axis.title.y = element_text(color="black", size=35, face="bold", vjust=0)) +
	theme(axis.title.x = element_text(color="black", size=40, face="bold")) +
	theme(axis.text.y = element_text(color="black", size=20)) +
	xlab("Red Foxes") +
	theme(axis.text.x = element_blank()) +
	theme(axis.ticks.x = element_blank()) +
	theme(panel.background = element_blank()) +
	geom_vline(xintercept = 75.5, lwd=1, colour="black", lty="longdash") +
	geom_vline(xintercept = 102.5, lwd=1, colour="black", lty="longdash") +
	geom_vline(xintercept = 137.5, lwd=1, colour="black", lty="longdash") +
	geom_vline(xintercept = 147.5, lwd=1, colour="black", lty="longdash") +
	guides(fill=FALSE)

ggsave("StructureBarplot_Historical.png", plot = stru, width=25,height=10, units="in", dpi=300, scale=0.8)
#Cleaned up in Inkscape

#LnP plot
r = read.table("Newfoundland_struHarv_LnP_Historical.txt", header = TRUE, row.names = NULL) #Output of STRUCTUREHARVESTER
png(file="LnP_Historical.png", units="in", height=12, width=17, res=200) #Set up the png you're making
par(mar=c(10,13,1,1), xpd=T)
scatterplot(r$meanLnP~r$K, xaxt="n",yaxt="n",ylab="",xlab="", ylim=c(-5700,-4800),smooth=FALSE, boxplot = FALSE, grid = FALSE, reg.line=FALSE, pch=16,col="black",cex=3, legend.plot = FALSE) #some hard-coded axis values...
lines(r$meanLnP~r$K, add=T, lwd=3)
axis(1, at=seq(1,10,1), labels=NULL, cex.axis=5, font.axis=2, tick=F, line=2)
axis(2, at=seq(-5700,-4700,400), labels=NULL, cex.axis=3, font=2, tick=F)
mtext("K", side=1, cex=6, font=2, line=8)
mtext("Log probability\nof the data  ", side=2, cex=5, font=2, line=4)
errbar( r$K,r$meanLnP,r$meanLnP+r$stdevLnP, r$meanLnP-r$stdevLnP, add = T, lwd=2, errbar.col = "black", pch = "")
dev.off()

##Modern only for fig. 3B
NF = read.table("Newfoundland_stru_Q_Modern_Final.txt", header=TRUE) #This is the output Q values from a K = 2 run of STRUCTURE in tab-delimited format, 21-locus dataset (modern only).
NF.m = melt(NF, id.var="ID")
stru1 = ggplot(NF.m, aes(x = ID, y = value, fill = variable, width = 1, ymax=1.0, ymin=0.0)) + 	#Just sets your x and y values and the fill determines groups. width = # is the width of the bar (from 0 to 1, the latter has no spacing)
	geom_bar(stat = "identity", colour = "white") + #colour="white" makes the sep. lines between bars white
	scale_fill_manual(values=c("goldenrod1", "firebrick1")) +  #Sets the colours (assigned by fill = variable above)
	coord_cartesian(ylim = c(-0.1,1)) + #Set your Y limit to be bound 0-1
	ylab("Probability of assignment\n") + #added newline char to increase space between label
	theme(axis.title.y = element_text(color="black", size=35, face="bold", vjust=0)) +
	theme(axis.title.x = element_text(color="black", size=40, face="bold")) +
	theme(axis.text.y = element_text(color="black", size=20)) +
	xlab("Red Foxes") +
	theme(axis.text.x = element_blank()) +
	theme(axis.ticks.x = element_blank()) +
	theme(panel.background = element_blank()) +
	geom_vline(xintercept = 75.5, lwd=1, colour="black", lty="longdash") +
	geom_vline(xintercept = 102.5, lwd=1, colour="black", lty="longdash") +
	geom_vline(xintercept = 137.5, lwd=1, colour="black", lty="longdash") +
	guides(fill=FALSE)

ggsave("StructureBarplot_Modern.png", plot = stru1, width=25,height=10,units="in", dpi=300, scale=0.8)
#Cleaned up in Inkscape

r = read.table("Newfoundland_struHarv_LnP_Modern.txt", header = TRUE, row.names = NULL)
png(file="LnP_Modern.png", units="in",height=12, width=17, res=200)
par(mar=c(10,13,2,1), xpd=T)
scatterplot(r$meanLnP~r$K, xaxt="n",yaxt="n",ylab="",xlab="", ylim=c(-8200,-6600), smooth=FALSE, boxplot = FALSE, grid = FALSE, reg.line=FALSE, pch=16,col="black",cex=3, legend.plot = FALSE)
lines(r$meanLnP~r$K, add=T, lwd=3)
axis(1, at=seq(1,10,1), labels=NULL, cex.axis=5, font.axis=2, tick=F, line=2)
axis(2, at=seq(-8200,-6600,400), labels=NULL,cex.axis=3, font=2, tick=F)
mtext("K", side=1, cex=6, font=2, line=8)
mtext("Log probability\nof the data", side=2, cex=5, font=2, line=4)
errbar( r$K,r$meanLnP,r$meanLnP+r$stdevLnP, r$meanLnP-r$stdevLnP, add = T, lwd=2, errbar.col = "black", pch = "")
dev.off()


##Less pretty barplots for the various values of K for supplement.
##To parse structure files, I used the following bash script:
#for i in $(seq 1 1 30); do paste <(paste --delimiter '' <(grep -A157 "Inferred ancestry of individuals" 100k1m_run_$i\_f | tail -n156 | sort -k 4,4 | awk '{print $4}') <(grep -A157 "Inferred ancestry of individuals" 100k1m_run_$i\_f | tail -n156 | sort -k 4,4 | awk '{print $2}')) <(grep -A157 "Inferred ancestry of individuals" 100k1m_run_$i\_f | tail -n156 | sort -k 4,4 | sed 's/  / /g' | awk '{ print substr($0, index($0,$6)) }') > Run_$i.parsed.txt; done

##Then looped those through this script to generate barplots for all K
for(NUMBER in 1:30){
NF = read.table(paste("STRU/Run_",NUMBER,".parsed.txt", sep=""), header=F) #This is the output Q values from a K = 2 run of STRUCTURE in tab-delimited format.
NF.m = melt(NF, id.var="V1")
stru = ggplot(NF.m, aes(x = V1, y = value, fill = variable, width = 1, ymax=1.0, ymin=0.0)) + 	#Just sets your x and y values and the fill determines groups. width = # is the width of the bar (from 0 to 1, the latter has no spacing)
	geom_bar(stat = "identity", colour = "black") + #colour="black" makes the sep. lines between bars black
	coord_cartesian(ylim = c(-0.1,1)) + #Set your Y limit to be bound 0-1
	ylab("Probability of assignment\n") + #added newline char to increase space between label
	theme(axis.title.y = element_text(color="black", size=35, face="bold", vjust=0)) +
	theme(axis.title.x = element_text(color="black", size=40, face="bold")) +
	theme(axis.text.y = element_text(color="black", size=20)) +
	theme(plot.title = element_text(color="black", size=30)) +
	ggtitle(paste("K =",length(NF[,2-3]))) + 
	xlab("") +
	theme(axis.text.x = element_blank()) +
	theme(axis.ticks.x = element_blank()) +
	theme(panel.background = element_blank()) +
	geom_vline(xintercept = 75.5, lwd=1, colour="black", lty="longdash") +
	geom_vline(xintercept = 102.5, lwd=1, colour="black", lty="longdash") +
	geom_vline(xintercept = 137.5, lwd=1, colour="black", lty="longdash") +
	geom_vline(xintercept = 147.5, lwd=1, colour="black", lty="longdash") +
	guides(fill=FALSE) +
	annotation_custom(grob=textGrob("fur farm",gp=gpar(fontsize=22, col="black")),xmin=37.5,xmax=37.5,ymin=-0.05, ymax=-0.05) +
	annotation_custom(grob=textGrob("south wild",gp=gpar(fontsize=22, col="black")),xmin=88.5,xmax=88.5,ymin=-0.05, ymax=-0.05) +
	annotation_custom(grob=textGrob("central wild",gp=gpar(fontsize=22, col="black")),xmin=119.5,xmax=119.5,ymin=-0.05, ymax=-0.05) +
	annotation_custom(grob=textGrob("north wild",gp=gpar(fontsize=22, col="black")),xmin=147,xmax=147,ymin=-0.075, ymax=-0.075) +
	annotation_custom(grob=textGrob("modern",gp=gpar(fontsize=18, col="black")),xmin=143,xmax=143,ymin=-0.025, ymax=-0.025) +
	annotation_custom(grob=textGrob("historical",gp=gpar(fontsize=18, col="black")),xmin=152,xmax=152,ymin=-0.025, ymax=-0.025)

ggsave(paste("STRU/StructureBarplot_",length(NF[,2-3]),"_",sample(1:50)[1],".png",sep=""), plot = stru, width=25,height=10,units="in", dpi=100, scale=0.8)
}


##################################################
##############    FIGURE 4: PCA     ##############
##################################################
library(adegenet)
library(png)

##Counted alleles using 'DNAOBJECT@loc.n.all' for Table 2##

########PCA WITH HISTORICAL (14 LOCI)#########
setwd("PATH")
DNA=read.structure("Newfoundland_RF_All_WithHistorical.stru", n.ind=156,n.loc=14,onerowperind=T,col.lab=1,col.pop=2,row.marknames=1, ask=F) #This is 4stru.txt with the file handle changed (structure formatted txt file)
X = tab(DNA, NA.method="zero") #tab() retrieves a matrix of allele data and NA.methods="zero" sets NA's (missing) to 0.
pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE) #this makes an object "pca1" that has the results of your PCA.
png(file="PCA_Historical.png", units="in", height=15, width=18.5, res=300)
par(mar=c(0,0,0,0), xpd=T)
#the next 2 lines assume the historical are the final n samples
#This will determine how many samples get assigned to each of two symbol types, circles for modern, square for historical
NonHistorical=length(which(pop(DNA)!="5")) #I used numbers for structure, so 5=Historical
Historical=length(which(pop(DNA)=="5"))
s.class(pca1$li,pop(DNA), label=NULL, cpoint=5,col=transp(c("firebrick1","darkgreen","black","dodgerblue1","dodgerblue1"),0.8), pch=c(rep(16,NonHistorical),rep(15,Historical)), grid=FALSE,cstar=F, axesell=F, addaxes=T)
text(3.75,0.25,"15.1%",cex=4) #from the command below giving us eigenvalues
text(0.65,3.25,"7.9%",cex=4) #from the command below giving us eigenvalues
(100*pca1$eig/sum(pca1$eig))[1:5] #This tells you the percent variation in your data for eigenvalues 1-5
legend("topright",pch=c(16,16,15,16,16), cex=2, text.font=2,col=transp(c("firebrick1","dodgerblue1","dodgerblue1","black","darkgreen"),0.8), leg=c("fur farm","modern north wild", "historical north wild","central wild","south wild"),pt.cex=4) #This legend was given samples sizes in parentheses and then clipped and added to Fig. 1 in Inkscape
#add.scatter.eig(pca1$eig[1:5],2,2,1, ratio=0.2, sub=NULL, posi="bottomleft")
dev.off()


########PCA WITH JUST WILD (INCLUDING HISTORICAL; 14 LOCI)#########
setwd("PATH")
DNA=read.structure("Newfoundland_RF_All_WithHistorical.stru", n.ind=156,n.loc=14,onerowperind=T,col.lab=1,col.pop=2,row.marknames=1, ask=F) #This is 4stru.txt with the file handle changed (structure formatted txt file)
Wild=which(pop(DNA)!="1")
DNAWild=DNA[Wild]
X = tab(DNAWild, NA.method="zero") #tab() retrieves a matrix of allele data and NA.methods="zero" sets NA's (missing) to 0.
png(file="PCA_Wild_Historical.png", units="in", height=15, width=22.5, res=300)
par(mar=c(0,0,0,0), xpd=T)
#The next line will remove the Fur Farm samples from the dataset
pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE) #this makes an object "pca1" that has the results of your PCA.
NonHistorical=length(which(pop(DNAWild)!="5"))
Historical=length(which(pop(DNAWild)=="5"))
s.class(pca1$li,pop(DNAWild), label=NULL, cpoint=5,col=transp(c("darkgreen","black","dodgerblue1","dodgerblue1"),0.8), pch=c(rep(16,NonHistorical),rep(15,Historical)), grid=FALSE,cstar=F, axesell=F, addaxes=T)
(100*pca1$eig/sum(pca1$eig))[1:5] #This tells you the percent variation in your data for eigenvalues 1-5
text(4.25,0.25,"10.6%",cex=4) #from the command below giving us eigenvalues (positions done by hand, in this case)
text(0.5,-3,"7.6%",cex=4) #from the command below giving us eigenvalues (positions done by hand, in this case)
legend("topright",pch=c(16,15,16,16), bg="white",cex=2, col=transp(c("dodgerblue1","dodgerblue1","black","darkgreen"),0.8), leg=c("modern north wild", "historical north wild","central wild","south wild"),pt.cex=4)
#add.scatter.eig(pca1$eig[1:5],2,2,1, ratio=0.2, sub=NULL, posi="bottomleft")
dev.off()


########PCA WITH JUST WILD (21 LOCI)#########
setwd("PATH")
DNA=read.structure("Newfoundland_RF_AllModern.stru", n.ind=147,n.loc=21,onerowperind=T,col.lab=1,col.pop=2,row.marknames=1, ask=F) #This is 4stru.txt with the file handle changed (structure formatted txt file)
Wild=which(pop(DNA)!="1")
DNAWild=DNA[Wild]
X = tab(DNAWild, NA.method="zero") #tab() retrieves a matrix of allele data and NA.methods="zero" sets NA's (missing) to 0.
png(file="PCA_Wild_ModernOnly.png", units="in", height=15, width=22.5, res=300)
par(mar=c(0,0,0,0), xpd=T)
pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE) #this makes an object "pca1" that has the results of your PCA.
s.class(pca1$li,pop(DNAWild), label=NULL, cpoint=5,col=transp(c("darkgreen","black","dodgerblue1"),0.8), pch=16, grid=FALSE,cstar=F, axesell=F, addaxes=T)
(100*pca1$eig/sum(pca1$eig))[1:5] #This tells you the percent variation in your data for eigenvalues 1-5
text(4.25,0.25,"9.4%",cex=4) #from the command below giving us eigenvalues (positions done by hand, in this case)
text(0.5,-3,"7.0%",cex=4) #from the command below giving us eigenvalues (positions done by hand, in this case)
legend("topright",pch=c(16,16,16), bg="white",cex=2, col=transp(c("dodgerblue1","black","darkgreen"),0.8), leg=c("modern north wild", "central wild","south wild"),pt.cex=4)
#add.scatter.eig(pca1$eig[1:5],2,2,1, ratio=0.2, sub=NULL, posi="bottomleft")
dev.off()


########PCA WITH JUST FURFARM#########
setwd("PATH")
DNA=read.structure("Newfoundland_RF_AllModern.stru", n.ind=147,n.loc=21,onerowperind=T,col.lab=1,col.pop=2,row.marknames=1, ask=F) #This is 4stru.txt with the file handle changed (structure formatted txt file)
FF=which(pop(DNA)=="1")
DNAFF=DNA[FF]
X = tab(DNAFF, NA.method="zero") #tab() retrieves a matrix of allele data and NA.methods="zero" sets NA's (missing) to 0.
png(file="PCA_FF.png", units="in", height=15, width=22.5, res=300)
par(mar=c(0,0,0,0), xpd=T)
#The next line will remove the Fur Farm samples from the dataset
pca1 <- dudi.pca(X,scannf=FALSE,scale=FALSE) #this makes an object "pca1" that has the results of your PCA.
s.class(pca1$li,pop(DNAFF), label=NULL, cpoint=5,col=transp("firebrick1",0.8), pch=16, grid=FALSE,cstar=F, axesell=F, addaxes=T)
legend("topright",pch=16, bg="white",cex=2, col=transp("firebrick1",0.8), leg="fur farm",pt.cex=4)
(100*pca1$eig/sum(pca1$eig))[1:5] #This tells you the percent variation in your data for eigenvalues 1-5
text(-5,0.3,"10.5%",cex=4) #from the command below giving us eigenvalues
text(.8,-3.2,"8.5%",cex=4) #from the command below giving us eigenvalues
#add.scatter.eig(pca1$eig[1:5],2,2,1, ratio=0.2, sub=NULL, posi="bottomright")
dev.off()


