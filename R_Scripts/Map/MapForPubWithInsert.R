setwd("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map")
library(maptools)
library(gpclib)
library(maps)
library(mapdata)
library(sp)
library(classInt)
library(rgdal)
library(png)
gpclibPermit()

Shape = readShapeLines("shapefiles/tl_2009_06_state.shp", 
proj4string=CRS("+proj=longlat"), verbose=TRUE,
repair=FALSE, delete_null_obj=FALSE)
Shape

Shape2 = readShapePoints("shapefiles/ZachsDeerGenotypes4poster_20130118.shp", 
proj4string=CRS("+proj=longlat"), verbose=FALSE, repair=FALSE)

getinfo.shape("shapefiles/cnty24k09_1_state_poly.shp")

plot.new()
par(mar=c(0.1,0.1,0.1,0.1))

plot(Shape, lwd=2, col="black")
plot(Shape2, pch=c(16), col="black", cex =1.75, add=T)


