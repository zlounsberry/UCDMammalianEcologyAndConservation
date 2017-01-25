setwd("V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\KrisKMap4Thesis")
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

Cpoints = read.table("Lat Long For Points.txt", row.names="ID", header = T) #Read a table of lat/longs

##From tutorials posted here: http://rpsychologist.com/working-with-shapefiles-projections-and-world-maps-in-ggplot
wmap = readOGR(dsn="V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/ShapeFiles4NewProj/ne_110m_land.shp", layer="ne_110m_land") #Land layer
wmap_df <- fortify(wmap) #Still not sure what fortify does, it's a ggplot thing and I have to look into it...
bbox = readOGR("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/ShapeFiles4NewProj/ne_110m_wgs84_bounding_box.shp", layer="ne_110m_wgs84_bounding_box") #bounding box, this is kinda the earth shape
bbox_df<- fortify(bbox)
countries = readOGR(dsn="V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/ShapeFiles4NewProj/ne_110m_admin_0_countries.shp", layer="ne_110m_admin_0_countries") #As you can guess, these contain the countries
countries_df <- fortify(countries)
grat = readOGR("V:/3730Data/377STRs/Wildlife/R Scripts/R Stuff/Map/ShapeFiles4NewProj/ne_110m_graticules_30.shp", layer="ne_110m_graticules_30") #not sure what this is either, it was part of the tutorial
grat_df <- fortify(grat)

wmap_wintri = spTransform(wmap, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
wmap_wintri_df <- fortify(wmap_wintri)  
bbox_wintri = spTransform(bbox, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
bbox_wintri_df <- fortify(bbox_wintri)
countries_wintri = spTransform(countries, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
countries_wintri_df <- fortify(countries_wintri)
grat_wintri = spTransform(grat, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))
grat_wintri_df <- fortify(grat_wintri)

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
                         plot.title = element_text(size=42)))

NewPoints=SpatialPoints(Cpoints)
crs(NewPoints) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
NewPoints_wintri=spTransform(NewPoints, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))

mapdata<-data.frame(NewPoints_wintri)
names(mapdata)[names(mapdata)=="mx"] = "x"
names(mapdata)[names(mapdata)=="my"] = "y"
NewPoints_wintri1 = fortify(mapdata)

ggplot(bbox_wintri_df, aes(long,lat, group=group)) + #plot the bounding box
  geom_polygon(fill="gray90") + #Make the ocean from the bounding box
  geom_polygon(data=countries_wintri_df, aes(long,lat, group=group, fill=hole)) + #make a polygon of just the countries  
  geom_polygon(fill="transparent",colour="black") +
  labs(title="Location of Red Fox Samples") + #Fancy title
  theme_opts + #Apply our themes from above
  geom_point(data=NewPoints_wintri1, aes(Longitude,Latitude, group=NULL, size=15),alpha = .8, colour="red") + #Oh look, I actually wrote a thing! This plots your newly projected points on your map.
  theme(legend.position="none") +
  coord_quickmap(xlim=c(-16005539, 16005539),ylim=c(-9328438,9328438)) + #ylim=c(-10018754,9328438)) +
  coord_fixed(xlim=c(-16005539, 16005539),ylim=c(-9328438,9328438)) +
  scale_fill_manual(values=c("white", "black"), guide="none") # change colors of countries & remove legend
  




Cpoints = read.table("Lat Long For Points With Counts.txt", row.names="ID", header = T) #Read a table of lat/longs

NewPoints=SpatialPoints(Cpoints)
crs(NewPoints) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
NewPoints_wintri=spTransform(NewPoints, CRS("+proj=wintri +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"))

mapdata<-data.frame(NewPoints_wintri)
NewPoints_wintri1 = fortify(mapdata)


p = ggplot(bbox_wintri_df, aes(long,lat, group=group)) + #plot the bounding box
  geom_polygon(fill="powderblue") + #Make the ocean from the bounding box
  geom_polygon(data=countries_wintri_df, aes(long,lat, group=group, fill=hole)) + #make a polygon of just the countries  
  geom_polygon(fill="transparent",colour="black") + # add an outline if you want
  geom_path(data=grat_wintri_df, aes(long, lat, group=group, fill=NULL), linetype="dashed", color="gray70") + 
  labs(title="Location of Red Fox Samples") + #Fancy title
  theme_opts + #Apply our themes from above
  geom_point(data=NewPoints_wintri1, aes(Longitude,Latitude, group=NULL, size=Count, colour=factor(Location)),alpha=.8) + 
  scale_color_manual(values=c("1"="firebrick1", "2"="darkblue")) +
  scale_size(range = c(5, 8)) +
  theme(legend.position="none") +
  coord_quickmap(xlim=c(-16005539, 16005539),ylim=c(-9328438,9328438)) + #ylim=c(-10018754,9328438)) +
  coord_fixed(xlim=c(-16005539, 16005539),ylim=c(-9328438,9328438)) +
  scale_fill_manual(values=c("lemonchiffon", "black"), guide="none") # change colors of countries & remove legend

ggsave("KrisMap.png", plot = p, dpi = 600)