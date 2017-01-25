setwd("V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman")
library(leaflet)
library(rgdal)
library(fifer)
library(maps)
library(maptools)
library(ggplot2)
library(rgeos)
library(raster)
library(spatstat)
library(rgdal)
library(ggmap)

#Read in the shapefiles and fix them up for ggplot2()
HexesMo=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\hexagon.kml", layer="HexMonterey")
HexesMo=spTransform(HexesMo, CRS("+proj=longlat +datum=WGS84 +no_defs"))
HexesMo_df=fortify(HexesMo)
Hexes=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\Shape files 5-6-13\\Hex.shp", layer="Hex")
Hexes=spTransform(Hexes, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
Hexes_df=fortify(Hexes)
Points=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\Shape files 5-6-13\\points.shp", layer="points")
Points=spTransform(Points, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

Cpoints = read.table("SLOandMonteryBearSamplingLocations.txt", row.names="Cell", header = T) #
NewPoints=SpatialPoints(Cpoints)
crs(NewPoints) = sp::CRS("+proj=longlat +datum=WGS84 +no_defs")


















#I found the layer name by looking for the field "name" in the hexagon.kml file and that read it in... Whatever.
HexesMo=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\hexagon.kml", layer="HexMonterey")
HexesMo=spTransform(HexesMo, CRS("+proj=longlat +datum=WGS84 +no_defs"))
HexesMo_df=fortify(HexesMo)

#Get the counties that we are looking at
CAco=CAcounty=map('county', c('california,monterey','california,san luis obispo'), fill=T, plot=F)
CAco1=map2SpatialPolygons(CAco,IDs=c('california,monterey','california,solano'),proj4string=CRS("+proj=longlat +datum=WGS84 +no_defs"))
CAco_df=fortify(CAco1)

#Read in sampling points
Cpoints = read.table("SLOandMonteryBearSamplingLocations.txt", row.names="Cell", header = T) #
NewPoints=SpatialPoints(Cpoints)
crs(NewPoints) = sp::CRS("+proj=longlat +datum=WGS84 +no_defs")

#Subset the sampling points to make sure they all fall within the study site polygons
proj4string(NewPoints) = CRS("+proj=longlat +datum=WGS84 +no_defs") 
mapdata=data.frame(NewPoints)
NewPoints=fortify(mapdata)

Points1=spTransform(NewPoints, CRS(proj4string(CAco1))) 
Points2=Points1[CAco1, ]
mapdata=data.frame(Points2)
NewPoints=fortify(mapdata)

#Get the counties that we are looking at
California=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\CAShapefiles\\State_With_County_Boundaries.shp", layer="State_With_County_Boundaries")
CAcounties=subset(California, COUNTY_COD=="27" | COUNTY_COD=="40") #27=Montery, 40=SLO
CAcounties=spTransform(CAcounties, CRS(proj4string(NewPoints)))
CAcounties_df=fortify(CAcounties)

#Make a blank theme
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

#get the right map (much of this credited to Cate Brown Quinn)
outline=map("state", "california", col="gray90", lwd=1, fill=T)

#turn into sp polygons, then to a data frame
CA=map2SpatialPolygons(outline,"CA", proj4string=CRS("+proj=longlat +datum=WGS84 +no_defs"))
CA_df=fortify(CA)

#make it into a bbox
sbbox=make_bbox(lon = CA_df$long, lat = CA_df$lat)

#Get a terrain background in black and white
spmap_T=get_map(location=sbbox, maptype=c("terrain-background"), source="google", color="bw", crop=T)

ggmap(spmap_T) +
  geom_path(data=CAcounties_df, aes(long,lat,group=group, fill=F)) +
  geom_path(data=CAco_df, aes(long,lat,group=group, fill=F)) +
  coord_quickmap(xlim=CA_df$long, ylim=CA_df$lat) +
  theme_opts  + 
  #geom_point(data=NewPoints, aes(Long,Lat, group=NULL, size=15),alpha = .8, colour="red") +
  #geom_path(data=Hex2_df, aes(long,lat,group=group, fill=F)) +
  theme(legend.position="none")


##This is how to 
#Read in hexes
Hexes=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\Shape files 5-6-13\\Hex.shp", layer="Hex")
Hexes=spTransform(Hexes, CRS("+proj=longlat +datum=WGS84 +no_defs"))
Hexes_df=fortify(Hexes)

#Subset Hexes to only cover points
proj4string(Points2) = CRS("+proj=longlat +datum=WGS84 +no_defs") 
Hex1=spTransform(Hexes, CRS(proj4string(Points2))) 
Hex1_df=fortify(Hex1)
Hex2=Hex1[Points2, ] #Subset Hexes to occur only within the convex hull containing the hair snare sites
Hex2_df=fortify(Hex2)




#####And the Inset:
Box=data.frame(lon=c(-121.4167,-121.4167,-119.8617,-119.8617),lat=c(35.88504,34.84611,34.84611,35.88504))

ggplot(Box, aes(lon,lat, group=NULL)) + 
  theme_opts + #Apply our themes from above
  geom_point(data=NewPoints, aes(Long,Lat, group=NULL), size=4,shape=21, alpha = .8, fill="gray50", colour="black") +
  geom_path(data=Hex2_df, aes(long,lat,group=group, fill=F)) +
  geom_path(data=HexesMo_df, aes(long,lat,group=group, fill=F)) +
  theme(legend.position="none") +
  scaleBar(lon = -121.5, lat = 35, distanceLon = 30, distanceLat = 5, distanceLegend = 10, dist.unit = "km", orientation = FALSE, legend.size = 10) +
  geom_path(data=CAco_df, aes(long,lat,group=group, fill=F))
