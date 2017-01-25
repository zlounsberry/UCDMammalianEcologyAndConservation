setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/NewfoundlandRF")
library(maptools)
library(gpclib)
library(maps)
library(mapproj)
library(mapdata)
library(sp)
library(classInt)
library(rgdal)
library(png)
library(raster)

gpclibPermit()

mycol=transp(c("black","firebrick1","dodgerblue1","darkgreen","yellow"), 0.4)

Shape = readShapeLines("newfoundland_and_labrador_administrative.shp", 
proj4string=CRS("+proj=longlat"), verbose=TRUE,
repair=FALSE, delete_null_obj=FALSE)

Shape2 = readShapeLines("newfoundland_and_labrador_coastline.shp", 
proj4string=CRS("+proj=longlat"), verbose=TRUE,
repair=FALSE, delete_null_obj=FALSE)

windows.options(width=20, height=20)
png(file='map.png')
plot.new()
par(mar=c(0.1,0.1,0.1,0.1))
map('worldHires', 'canada', lwd=2)
#map('worldHires', 'canada:Newfoundland', fill=T, col="gray50", add=T)
plot(Shape, add=T, lwd=2)
rect(-69,46,-52.5,61, lwd=3, lty=3)

dev.off()

map1=readPNG("map.png")

windows.options(width=30, height=30)
plot.new()
par(mar=c(0.1,0.1,0.1,0.1), xpd=T)

plot(Shape, lwd=3, col="black", xlim=c(-72,-54.5), ylim=c(46,61))
rect(-53.65,47,-53.33,47.45, lwd=0, border="white",col="white")
rect(-64,51,-57.2,51.7, lwd=0, border="white",col="white")
rect(-64,49,-58.6,51.7, lwd=0, border="white",col="white")

#plot(Shape2, lwd=2, col="black", add=T)
#plot(Shape3, col="gray30", add=T) #Roads

FurFarm = read.table("Pop1.txt", header = TRUE, row.names = NULL)
South  = read.table("Pop2.txt", header = TRUE, row.names = NULL)
Central = read.table("Pop3.txt", header = TRUE, row.names = NULL)
North = read.table("Pop4.txt", header = TRUE, row.names = NULL)

points(FurFarm$long,FurFarm$lat, col=mycol[2], cex=3,pch=19) 
points(North$long,North$lat, col=mycol[3], cex=3,pch=19)
points(Central$long,Central$lat, col=mycol[1], cex=3,pch=19)
points(South $long,South$lat, col=mycol[4], cex=3,pch=19) 

rasterImage(map1, -76, 55.5, -65,62)
legend(-75, 51.5, c("Fur Farm","North","Central","South"), pch=c(19,19,19,19), cex=3, pt.cex=4, col=transp(c("firebrick1","dodgerblue1","black","darkgreen"), 0.8), bty="n")


