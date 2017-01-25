setwd("C://Users//Zach//Desktop//R Stuff//Map")
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

#####Plotting Davis on a Map of The Americas##########


#plotting countries within 'worldHires'
alaska = readShapeLines("shapefiles/tl_2009_02_state.shp", 
proj4string=CRS("+proj=longlat"), verbose=TRUE,
repair=FALSE, delete_null_obj=FALSE)
plot.new()
par(mar=c(0.1,0.1,0.1,0.1))
map('worldHires',c('Canada','Mexico','Antigua','Barbados','Belize',
'Costa Rica','Cuba','Dominica','Dominican Republic',
'El Salvador','Grenada','Guatemala','Haiti','Honduras','Jamaica',
'Nicaragua','Panama','The Bahamas','Trinidad ','Tobago','Nevis','Argentina','Bolivia','Brazil',
'Chile','Colombia','Ecuador','French Guiana','Guyana','Paraguay','Peru','Suriname','Uruguay',
'Venezuela'), xlim=c(-175,-20), fill = TRUE, 
col = "white")
plot(alaska, lwd= 1, add=TRUE)
map("usa", fill = TRUE, col = "white", add=TRUE)
map.scale(-175, -40, relwidth = 0.30, metric = TRUE, ratio = TRUE)
points(-121.762826,38.530366,col="darkblue", cex=1.25,pch=19)


#########################Alaska Map#############################
alaska = readShapeLines("shapefiles/tl_2009_02_state.shp", 
proj4string=CRS("+proj=longlat"), verbose=TRUE,
repair=FALSE, delete_null_obj=FALSE)
plot(alaska, lwd= 1, xlim=c(-170,-130))


###################Putting Haplos on the Map!################################
Pie = read.table("Pie Charts/Pie.txt", header = TRUE)
#Windows doesn't support transparency or some BS, so I just made the 
#	white backgrounds trasparent in PPT and saved new files...
pie(c(1:4), labels=NA, col=c("pink", "black", "green", "purple")) #Used these to generate fake pie charts

map("usa", fill = TRUE, lwd=2, col = "white")
map("rivers", lwd = 2, lty = 2, col = "dodgerblue1", add=TRUE)

Pie1t = readPNG("Pie Charts/Pie1t.png")
Long1 = -121.762826
Lat1 = 38.530366
rasterImage(Pie1t, Long1, Lat1, Long1+4, Lat1+3)
Pie2t = readPNG("Pie Charts/Pie3t.png")
Long2 = -83.762826
Lat2 = 30.530366
rasterImage(Pie2t, Long2, Lat2, Long2+4, Lat2+3)
Pie3t = readPNG("Pie Charts/Pie2t.png")
Long3 = -75.762826
Lat3 = 38.530366
rasterImage(Pie3t, Long3, Lat3, Long3+4, Lat3+3)


##########HOORAY that worked, now to do it in a practical way... With pies... ###########
library(ggplot2)
setwd("C://Users//Zach//Desktop//R Stuff//Map//Sarah Data")
map("usa", fill = TRUE, lwd=2, col = "white")
map("rivers", lwd = 2, lty = 2, col = "dodgerblue1", add=TRUE)
Haplotypes = read.table("Haplotypes.txt", header = TRUE)
HaplotypesT = read.table("Haplotypest.txt", header = TRUE)
HaplotypesL = read.table("Haplotypes_Long.txt", header = TRUE)

HaplotypesL

pie(Haplotypes$CapeDyer, col=c(1:31), labels=NA)#Now copy this into ppt and make white transparent... Then save as a png with whatever name you want. Here, Pie1t
pie(Haplotypes$CapeKrusenstern, col=c(1:31), labels=NA)#Now copy this into ppt and make white transparent... Then save as a png with whatever name you want. Here, Pie1t
pie(Haplotypes$DeeringAlaska, col=c(1:31), labels=NA)#Now copy this into ppt and make white transparent... Then save as a png with whatever name you want. Here, Pie1t
pie(Haplotypes$KotzebueNWAlaska, col=c(1:31), labels=NA)#Now copy this into ppt and make white transparent... Then save as a png with whatever name you want. Here, Pie1t
pie(Haplotypes$StLawrenceIsland, col=c(1:31), labels=NA)#Now copy this into ppt and make white transparent... Then save as a png with whatever name you want. Here, Pie1t
pie(Haplotypes$OnionPortage, col=c(1:31), labels=NA)#Now copy this into ppt and make white transparent... Then save as a png with whatever name you want. Here, Pie1t
pie(Haplotypes$PointHope, col=c(1:31), labels=NA)#Now copy this into ppt and make white transparent... Then save as a png with whatever name you want. Here, Pie1t
pie(Haplotypes$PtBarrowAlaska, col=c(1:31), labels=NA)#Now copy this into ppt and make white transparent... Then save as a png with whatever name you want. Here, Pie1t
pie(Haplotypes$KodiakIsland, col=c(1:31), labels=NA)#Now copy this into ppt and make white transparent... Then save as a png with whatever name you want. Here, Pie1t

Pie1 = readPNG("Bitmap/Pie1t.png") #now read it your pie chart as a new object
Long1 = -121.762826
Lat1 = 38.530366
rasterImage(Pie1t, Long1, Lat1, Long1+4, Lat1+3)

################Plotting the world or the US with my Cali map and Site##################
rm(list=ls())
plot.new()
par(mar=c(0.1,0.1,0.1,0.1))
World = map('worldHires')
USA= map('usa')
plot(World, lwd=2, col="darkblue", type="l", xaxt="n", yaxt="n",
ylab="", xlab="")
plot(USA, lwd=2, col="darkblue", type = "l", xaxt="n", yaxt="n",
ylab="", xlab="")
plot(Shape, lwd=1.5, col="blue", add=TRUE)
plot(Shape2, pch=c(2,19), col="forestgreen", cex =0.75, add=T)


####################Buffy Map for Point Plotting#########################################
setwd("C:/Users/Zach/Desktop/R Stuff/Map/Buffy")
plot.new()
par(mar=c(.01,.1,.01,.01))
alaska = readShapeLines("shapefiles/tl_2009_02_state.shp", 
proj4string=CRS("+proj=longlat"), verbose=TRUE,
repair=FALSE, delete_null_obj=FALSE)
Bpoints = read.table("Lat Long For Points.txt", row.names="ID", header = T) #Read a table of lat/longs

plot(alaska, lwd= 1, xlim=c(-170,-140))
points(Bpoints$LongE,Bpoints$latN,col="darkblue", cex=2.25,pch=4) #plot it in the usual Long, Lat format.


###Buffy's across the world##########
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
points(Cpoints$LongE,Cpoints$latN,col="black", bg="tan4", cex=1.2,pch=23) 
points(PrePoints$Long,PrePoints$Lat, cex=1.25,pch=21, bg="dodgerblue1", col="black") #1885-1919
points(EarlyPostPoints$Long,EarlyPostPoints$Lat,bg="red2", col="black", cex=1.25,pch=22) #1920-1959
points(LatePostPoints$Long,LatePostPoints$Lat,bg="yellow", col="black", cex=1.25,pch=24) #1960-1985


#Add Scale and Legend
map.scale(-165, -13, relwidth = 0.30, metric = TRUE, ratio = FALSE) ##Now drop a scale on there for good measure.
legend(-165, 33, legend=c("Pre-MBTA","Early Post-MBTA", "Late Post-MBTA", "Modern"), 
pch=c(21,22,24,23), pt.bg=c("dodgerblue1","red2","yellow", "tan4"),
col=c("black"),pt.cex=c(1.25))


###############2012 for fun#######################
all2012 = read.table("All2012/knownlatlongforfun.txt", stringsAsFactors= TRUE, header = TRUE, row.names = "ID")
all2012

plot.new()
par(mar=c(0.01,0.1,0.01,0.1))

Cali = readShapeLines("shapefiles/tl_2009_06_state.shp", 
proj4string=CRS("+proj=longlat"), verbose=TRUE,
repair=FALSE, delete_null_obj=FALSE)
plot(Cali, lwd=1.5, col="tan4")

map('worldHires',c('Canada','Mexico','Antigua','Barbados','Belize',
'Costa Rica','Cuba','Dominica','Dominican Republic',
'El Salvador','Grenada','Guatemala','Haiti','Honduras','Jamaica',
'Nicaragua','Panama','The Bahamas','Trinidad ','Tobago','Nevis','Argentina','Bolivia','Brazil',
'Chile','Colombia','Ecuador','French Guiana','Guyana','Paraguay','Peru','Suriname','Uruguay',
'Venezuela'), xlim=c(-175,-20), ylim=c(-55, 80), fill = TRUE, 
col = "white")
plot(alaska, lwd= 1, add=TRUE)
map("usa", fill = TRUE, col = "white", add=TRUE)
points(all2012$Lon,all2012$Lat, cex=1.25, pch=24, bg="dodgerblue1", col="black")

?points
sp = as.factor(all2012$sp)
sp
?read.table

####################Satellite Maps!#################################
library(OpenStreetMap)
library(rJava)
plot.new()
par(mar=c(0.01,0.1,0.01,0.1))
map_longlat <- openproj(map, projection = "+proj=longlat")
plot(map_longlat,raster=TRUE)
map('worldHires', lwd = 1.5, col = "dodgerblue1", add=TRUE)
map('usa', lwd = 1.5, col = "white", add=TRUE)
Cali = readShapeLines("shapefiles/tl_2009_06_state.shp", 
proj4string=CRS("+proj=longlat"), verbose=TRUE,
repair=FALSE, delete_null_obj=FALSE)
plot(Cali, lwd=1.5, col="red", add=T)

map <- openmap(c(70,-50), c(-70,50),type='bing')
plot(map,raster=TRUE)
