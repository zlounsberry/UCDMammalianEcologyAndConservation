setwd("C://Users//Zach//Desktop//R Stuff//Map//Buffy")
library(maptools)
library(gpclib)
library(maps)
library(mapdata)
library(sp)
library(classInt)
library(rgdal)
library(png)
gpclibPermit()
alaska = readShapeLines("tl_2009_02_state.shp", proj4string=CRS("+proj=longlat"), verbose=TRUE, repair=FALSE, delete_null_obj=FALSE)
PrePoints = read.table("LatLong pre.txt", header = TRUE, row.names = "Sample")
EarlyPostPoints = read.table("LatLong early.txt", header = TRUE, row.names = "Sample")
LatePostPoints = read.table("LatLong late.txt", header = TRUE, row.names = "Sample")
Cpoints = read.table("Lat Long For Points.txt", row.names="ID", header = T) #Read a table of lat/longs


plot.new()
par(mar=c(0.01,0.1,0.01,0.1))
map('worldHires',c('Canada','Mexico','Antigua','Barbados','Belize',
'Costa Rica','Cuba','Dominica','Dominican Republic',
'El Salvador','Grenada','Guatemala','Haiti','Honduras','Jamaica',
'Nicaragua','Panama','The Bahamas','Trinidad ','Tobago','Nevis','Argentina','Bolivia','Brazil',
'Chile','Colombia','Ecuador','French Guiana','Guyana','Paraguay','Peru','Suriname','Uruguay',
'Venezuela'), xlim=c(-175,-20), ylim=c(-55, 80), fill = TRUE, 
col = "white")
plot(alaska, lwd= 1, add=TRUE)
map("usa", fill = TRUE, col = "white", add=TRUE)
points(Cpoints$LongE,Cpoints$latN,col="black", bg="yellow", cex=1.2,pch=23) 
points(PrePoints$Long,PrePoints$Lat, cex=1.25,pch=21, bg="blue", col="black") #1885-1919
points(EarlyPostPoints$Long,EarlyPostPoints$Lat,bg="darkgreen", col="black", cex=1.25,pch=22) #1920-1959
points(LatePostPoints$Long,LatePostPoints$Lat,bg="green", col="black", cex=1.25,pch=24) #1960-1985

map.scale(-165, -13, relwidth = 0.30, metric = TRUE, ratio = FALSE) ##Now drop a scale on there for good measure.
legend(-165, 33, legend=c("Pre-Act","Early Post-Act", "Late Post-Act", "Modern"), 
pch=c(21,22,24,23), pt.bg=c("blue","darkgreen","green", "yellow"),
col=c("black"),pt.cex=c(1.25))



