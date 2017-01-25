setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/NewfoundlandRF")
library(maptools)
library(gpclib)
library(maps)
library(mapdata)
library(sp)
library(classInt)
library(png)
library(raster)
library(rgdal)
library(fifer)
library(ggplot2)

FF=read.table("Pop1.txt", row.names=NULL, header=T)
FF=SpatialPoints(FF[,c(2,3)])
crs(FF) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
mapdata<-data.frame(FF)
FF_df= fortify(mapdata)
FF_wintri=spTransform(FF, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
mapdata<-data.frame(FF_wintri)
FF_wintri = fortify(mapdata)

SW=read.table("Pop2.txt", row.names=NULL, header=T)
SW=SpatialPoints(SW[,c(2,3)])
crs(SW) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
mapdata<-data.frame(SW)
SW_df= fortify(mapdata)
SW_wintri=spTransform(SW, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
mapdata<-data.frame(SW_wintri)
SW_wintri = fortify(mapdata)

CW=read.table("Pop3.txt", row.names=NULL, header=T)
CW=SpatialPoints(CW[,c(2,3)])
crs(CW) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
mapdata<-data.frame(CW)
CW_df= fortify(mapdata)
CW_wintri=spTransform(CW, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
mapdata<-data.frame(CW_wintri)
CW_wintri = fortify(mapdata)

NW=read.table("Pop4.txt", row.names=NULL, header=T)
NW=SpatialPoints(NW[,c(2,3)])
crs(NW) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
mapdata<-data.frame(NW)
NW_df= fortify(mapdata)
NW_wintri=spTransform(NW, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
mapdata<-data.frame(NW_wintri)
NW_wintri = fortify(mapdata)

Hist=read.table("Pop5_hist.txt", row.names=NULL, header=T)
Hist=SpatialPoints(Hist[,c(2,3)])
crs(Hist) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
mapdata<-data.frame(Hist)
Hist_df= fortify(mapdata)
Hist_wintri=spTransform(Hist, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
mapdata<-data.frame(Hist_wintri)
Hist_wintri = fortify(mapdata)


##From tutorials posted here: http://rpsychologist.com/working-with-shapefiles-projections-and-world-maps-in-ggplot
wmap = readOGR(dsn="V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/ShapeFiles4NewProj/ne_110m_land.shp", layer="ne_110m_land") #Land layer
wmap_df = fortify(wmap) #Still not sure what fortify does, it's a ggplot thing and I have to look into it...
bbox = readOGR("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/ShapeFiles4NewProj/ne_110m_wgs84_bounding_box.shp", layer="ne_110m_wgs84_bounding_box") #bounding box, this is kinda the earth shape
bbox_df = fortify(bbox)
countries = readOGR(dsn="V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/ShapeFiles4NewProj/ne_110m_admin_0_countries.shp", layer="ne_110m_admin_0_countries") #As you can guess, these contain the countries
countries_df = fortify(countries)
Canada = readOGR("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/NewfoundlandRF/Canada.shp", layer="Canada") #source https://www.arcgis.com/home/item.html?id=dcbcdf86939548af81efbd2d732336db
Canada = spTransform(Canada, CRS("+proj=longlat +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
Canada_df = fortify(Canada)
grat = readOGR("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/ShapeFiles4NewProj/ne_110m_graticules_30.shp", layer="ne_110m_graticules_30") #not sure what this is either, it was part of the tutorial
grat_df = fortify(grat)


wmap_wintri = spTransform(wmap, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
wmap_wintri_df <- fortify(wmap_wintri)  
bbox_wintri = spTransform(bbox, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
bbox_wintri_df <- fortify(bbox_wintri)
countries_wintri = spTransform(countries, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
countries_wintri_df <- fortify(countries_wintri)
Canada_wintri = spTransform(Canada, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")) #source: https://www.arcgis.com/home/item.html?id=dcbcdf86939548af81efbd2d732336db
Canada_wintri_df <- fortify(Canada_wintri)
grat_wintri = spTransform(grat, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
grat_wintri_df <- fortify(grat_wintri)
Shape_wintri = spTransform(Shape, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
Shape_wintri_df <- fortify(Shape_wintri)
test_wintri= spTransform(test, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
test_wintri_df <- fortify(test_wintri)



theme_opts <- list(theme(panel.grid.minor = element_blank(),
                         panel.grid.major = element_blank(),
                         panel.background = element_blank(),
                         plot.background = element_rect(fill="white"),
                         panel.border = element_blank(),
                         axis.line = element_blank(),
                         axis.text.x = element_blank(),
                         axis.text.y = element_blank(),
                         axis.ticks = element_blank(),
                         axis.title.x = element_blank(),
                         axis.title.y = element_blank(),
					   plot.margin=unit(c(0,0,0,0),"mm"),
                         plot.title = element_text(size=42)))

#Whole world:
ggplot(bbox_wintri_df, aes(long,lat, group=group)) + #plot the bounding box
  geom_polygon(fill="deepskyblue1", alpha=0.2) + #Make the ocean from the bounding box
  geom_polygon(data=countries_wintri_df, aes(long,lat, group=group, fill=hole), fill="black") + #make a polygon of just the countries  
  #geom_polygon(data=Canada_wintri_df, aes(long,lat, group=group, fill=hole,lwd=2), col="black", fill="gray75") + #make a polygon of just the countries  
  geom_polygon(fill="transparent",colour="black") +
  theme_opts + #Apply our themes from above
  geom_point(data=FF_wintri, aes(long,lat, group=NULL, size=15),alpha = .5, pch=21, fill="firebrick1") + 
  geom_point(data=NW_wintri, aes(long,lat, group=NULL, size=15),alpha = .5, pch=21, fill="dodgerblue1") + 
  geom_point(data=CW_wintri, aes(long,lat, group=NULL, size=15),alpha = .5, pch=21, fill="black") + 
  geom_point(data=SW_wintri, aes(long,lat, group=NULL, size=15),alpha = .5, pch=21, fill="darkgreen") + 
  geom_point(data=Hist_wintri, aes(long,lat, group=NULL, size=15),alpha = .8, pch=22, fill="white") + 
  geom_curve(data=NULL, aes(x = -3952166, y = 5281870, xend = -4752166, yend = 5281870, size=2, type="dashed"),curvature = -0.05) +
  geom_curve(data=NULL, aes(x = -3952166, y = 5281870, xend = -3952166, yend = 6951870, size=2, type="dashed"),curvature = -0.05) +
  geom_curve(data=NULL, aes(x = -4752166, y = 6951870, xend = -3952166, yend = 6951870, size=2, type="dashed"),curvature = 0.05) +
  geom_curve(data=NULL, aes(x = -4752166, y = 6951870, xend = -4752166, yend = 5281870, size=2, type="dashed"),curvature = 0.05) +
  theme(legend.position="none") +
  coord_quickmap(xlim=c(-10005539,-3600000),ylim=c(3000000,9328438)) + 
  coord_fixed(xlim=c(-10005539,-3600000),ylim=c(3000000,9328438)) +
  scale_fill_manual(values=c("white", "black"), guide="none") # change colors of countries & remove legend
 

ggplot(data=Canada_wintri_df, aes(long,lat, group=group)) + #plot the bounding box
  theme_opts + #Apply our themes from above
  geom_polygon(data=bbox_wintri_df,fill="deepskyblue1") + #Make the ocean from the bounding box
  geom_polygon(aes(long,lat, group=group, fill=hole,lwd=2), col="black", fill="gray75") + #make a polygon of just the countries  
  geom_point(data=FF_wintri, aes(long,lat, group=NULL, size=20), alpha = .5, pch=21, fill="firebrick1") + 
  geom_point(data=NW_wintri, aes(long,lat, group=NULL,size=20),alpha = .5, pch=21, fill="dodgerblue1") + 
  geom_point(data=CW_wintri, aes(long,lat, group=NULL,size=20),alpha = .5, pch=21, fill="black") + 
  geom_point(data=SW_wintri, aes(long,lat, group=NULL,size=20),alpha = .5, pch=21, fill="darkgreen") + 
  geom_point(data=Hist_wintri, aes(long,lat, group=NULL, size=20),alpha = .8, pch=22, fill="white") + 
  theme(legend.position="none") +
  coord_quickmap(xlim=c(-4752166, -3952166),ylim=c(5301870,6801870)) + 
  coord_fixed(xlim=c(-4752166, -3952166),ylim=c(5301870,6801870)) +
  scale_fill_manual(values=c("white", "black"), guide="none") # change colors of countries & remove legend
  


##BNS suggestions:


#Whole world:
ggplot(bbox_wintri_df, aes(long,lat, group=group)) + #plot the bounding box
  geom_polygon(fill="deepskyblue1", alpha=0.2) + #Make the ocean from the bounding box
  geom_polygon(data=countries_wintri_df, aes(long,lat, group=group, fill=hole, lwd=1.5), col="black", fill="gray75") + #make a polygon of just the countries  
  #geom_polygon(data=Canada_wintri_df, aes(long,lat, group=group, fill=hole,lwd=2), col="black", fill="gray75") + #make a polygon of just the countries  
  geom_polygon(fill="transparent",colour="black") +
  theme_opts + #Apply our themes from above
  geom_point(data=FF_wintri, aes(long,lat, group=NULL, size=15),alpha = .5, pch=21, fill="firebrick1") + 
  geom_point(data=NW_wintri, aes(long,lat, group=NULL, size=15),alpha = .5, pch=21, fill="dodgerblue1") + 
  geom_point(data=CW_wintri, aes(long,lat, group=NULL, size=15),alpha = .5, pch=21, fill="black") + 
  geom_point(data=SW_wintri, aes(long,lat, group=NULL, size=15),alpha = .5, pch=21, fill="darkgreen") + 
  geom_point(data=Hist_wintri, aes(long,lat, group=NULL, size=15),alpha = .8, pch=22, fill="white") + 
  geom_curve(data=NULL, aes(x = -3952166, y = 5281870, xend = -4752166, yend = 5281870, size=1.5),curvature = -0.05) +
  geom_curve(data=NULL, aes(x = -3952166, y = 5281870, xend = -3952166, yend = 6951870, size=1.5),curvature = -0.05) +
  geom_curve(data=NULL, aes(x = -4752166, y = 6951870, xend = -3952166, yend = 6951870, size=1.5),curvature = 0.05) +
  geom_curve(data=NULL, aes(x = -4752166, y = 6951870, xend = -4752166, yend = 5281870, size=1.5),curvature = 0.05) +
  theme(legend.position="none") +
  coord_quickmap(xlim=c(-10005539,-3600000),ylim=c(3000000,9328438)) + 
  coord_fixed(xlim=c(-10005539,-3600000),ylim=c(3000000,9328438)) +
  scale_fill_manual(values=c("white", "black"), guide="none") # change colors of countries & remove legend
 

ggplot(data=Canada_wintri_df, aes(long,lat, group=group)) + #plot the bounding box
  theme_opts + #Apply our themes from above
  geom_polygon(data=bbox_wintri_df,fill="deepskyblue1", alpha=0.2) + #Make the ocean from the bounding box
  geom_polygon(aes(long,lat, group=group, fill=hole,lwd=2), col="black", fill="gray75") + #make a polygon of just the countries  
  geom_point(data=FF_wintri, aes(long,lat, group=NULL, size=20), alpha = .5, pch=21, fill="firebrick1") + 
  geom_point(data=NW_wintri, aes(long,lat, group=NULL,size=20),alpha = .5, pch=21, fill="dodgerblue1") + 
  geom_point(data=CW_wintri, aes(long,lat, group=NULL,size=20),alpha = .5, pch=21, fill="black") + 
  geom_point(data=SW_wintri, aes(long,lat, group=NULL,size=20),alpha = .5, pch=21, fill="darkgreen") + 
  geom_point(data=Hist_wintri, aes(long,lat, group=NULL, size=20),alpha = .8, pch=22, fill="white") + 
  theme(legend.position="none") +
  coord_quickmap(xlim=c(-4752166, -3952166),ylim=c(5301870,6801870)) + 
  coord_fixed(xlim=c(-4752166, -3952166),ylim=c(5301870,6801870)) +
  scale_fill_manual(values=c("white", "black"), guide="none") # change colors of countries & remove legend
  

#PlottedbySize
AllPops=read.table("allpopscombined2.txt", row.names=NULL, header=T)
AllPops=SpatialPointsDataFrame(coords=AllPops[,c(2,3)], data=AllPops)
crs(AllPops) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
mapdata<-data.frame(AllPops)
AllPops_df= fortify(mapdata)
AllPops_wintri=spTransform(AllPops, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
mapdata<-data.frame(AllPops_wintri)
AllPops_wintri = fortify(mapdata)


ggplot(bbox_wintri_df, aes(long,lat, group=group, lwd=1),lwd=1) + #plot the bounding box
  geom_polygon(fill="white", alpha=0.1) + #Make the ocean from the bounding box
  geom_polygon(data=countries_wintri_df, aes(long,lat, group=group, fill=hole), lwd=1, col="black", fill="gray85") + #make a polygon of just the countries  
  #geom_polygon(data=Canada_wintri_df, aes(long,lat, group=group, fill=hole),lwd=2, col="black", fill="gray85") + #make a polygon of just the countries  
  geom_polygon(fill="transparent",colour="black") +
  theme_opts + #Apply our themes from above
  geom_point(data=AllPops_wintri, aes(long.1,lat.1, group=NULL, size=count, fill=OriginalPopID),alpha=0.9,fill=c("firebrick1","darkgreen",rep("black",2),"dodgerblue1",rep("yellow",5)), pch=c(21,21,rep(21,2),21,rep(22,5))) + 
  scale_size_continuous("points",range=c(2,7)) +
  geom_curve(data=NULL, aes(x = -3952166, y = 5281870, xend = -4752166, yend = 5281870,lwd=1), curvature = -0.05) +
  geom_curve(data=NULL, aes(x = -3952166, y = 5281870, xend = -3952166, yend = 6951870,lwd=1),curvature = -0.05) +
  geom_curve(data=NULL, aes(x = -4752166, y = 6951870, xend = -3952166, yend = 6951870,lwd=1),curvature = 0.05) +
  geom_curve(data=NULL, aes(x = -4752166, y = 6951870, xend = -4752166, yend = 5281870,lwd=1),curvature = 0.05) +
  theme(legend.position="none") +
  coord_quickmap(xlim=c(-10005539,-3600000),ylim=c(3000000,9328438)) + 
  coord_fixed(xlim=c(-10005539,-3600000),ylim=c(3000000,9328438))
 

ggplot(data=Canada_wintri_df, aes(long,lat, group=group),lwd=2) + #plot the bounding box
  theme_opts + #Apply our themes from above
  geom_polygon(data=bbox_wintri_df,fill="white", alpha=0.1) + #Make the ocean from the bounding box
  geom_polygon(aes(long,lat, group=group, fill=hole), col="black", fill="gray85") + #make a polygon of just the countries  
  geom_point(data=AllPops_wintri, aes(long.1,lat.1, group=NULL, size=count, fill=OriginalPopID),alpha=0.95,fill=c("firebrick1","darkgreen",rep("black",2),rep("dodgerblue1",6)), pch=c(21,21,rep(21,2),21,rep(22,5))) + 
  scale_size_continuous("points",range=c(5,15)) +
  theme(legend.position="none") +
  coord_quickmap(xlim=c(-4752166, -3952166),ylim=c(5301870,6801870)) + 
  coord_fixed(xlim=c(-4752166, -3952166),ylim=c(5301870,6801870)) 

