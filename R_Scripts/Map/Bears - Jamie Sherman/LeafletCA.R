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

#Read in the sampling points
Cpoints = read.table("SLOandMonteryBearSamplingLocations.txt", row.names="Cell", header = T) #
NewPoints=SpatialPoints(Cpoints)
NewPoints=SpatialPointsDataFrame(NewPoints,Cpoints)
crs(NewPoints) = sp::CRS("+proj=longlat +datum=WGS84 +no_defs")

#Read in the shapefiles and fix them up for ggplot2()
HexesMo=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\hexagon.kml", layer="HexMonterey")
HexesMo=spTransform(HexesMo, CRS(proj4string(NewPoints)))
HexesMo=HexesMo[NewPoints, ]
#HexesMo_df=fortify(HexesMo)

Hexes=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\Shape files 5-6-13\\Hex.shp", layer="Hex")
Hexes=spTransform(Hexes, CRS(proj4string(NewPoints)))
Hexes=Hexes[NewPoints, ]
#Hexes_df=fortify(Hexes)

#Using state_basic from https://www.arcgis.com/home/item.html?id=f7f805eb65eb4ab787a0a3e1116ca7e5
US=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\CAShapefiles\\states.shp", layer="states")
CAoutline=subset(US, STATE_NAME=="California")
CAoutline=spTransform(CAoutline, CRS(proj4string(NewPoints)))

#Using Jamie's StateCA file, I need to figure out where it's from
California=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\CAShapefiles\\State_With_County_Boundaries.shp", layer="State_With_County_Boundaries")
CAcounties=subset(California, COUNTY_COD=="27" | COUNTY_COD=="40") #27=Montery, 40=SLO
CAcounties=spTransform(CAcounties, CRS(proj4string(NewPoints)))
#CAcounties_df=fortify(CAcounties)

Box=data.frame(lon=c(-121.9812,-121.9812,-119.4726,-119.4726),lat=c(36.91976,34.89752,34.89752,36.91976))

leaflet(CAoutline) %>% 
  setView(-118.5, 38, 5) %>% 
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', 
           'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community') %>%
  #addPolygons(Box$lon, Box$lat, opacity=1, fillOpacity=1, color="black", fillColor="white", fill=T, weight=3) %>% #Box around the study site, if necessary...
  addPolygons(color="gray50", opacity=1, weight=5) %>%
  addPolygons(data=CAcounties, group=NULL, color="black", opacity=1, fill=T, fillColor="white", fillOpacity=0.3, weight=3) %>%
  addPolygons(data=Hexes, group=NULL, color="black", opacity=1, weight=0.3) %>%
  addPolygons(data=HexesMo, group=NULL, color="black", opacity=1, weight=0.3) %>%
  addCircles(lng=NewPoints@coords[,1],lat=NewPoints@coords[,2], color="gray50", opacity=1, weight=3)








#Just CA with the study site highlighted
leaflet(CAoutline) %>% 
  setView(-118.5, 38, 5) %>% 
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', 
           'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community') %>%
  addPolygons(color="gray50", opacity=1, weight=3) %>%
  addPolygons(lng=c(-121.3167,-121.3167,-119.9617,-119.9617),lat=c(35.78504,34.94611,34.94611,35.78504), opacity=1, color="white", fill=F, weight=5)


#Study site with details:
proj4string(Points) = CRS("+init=EPSG:3857 +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
hull=gConvexHull(Points)
hull=spTransform(hull, CRS(proj4string(Hexes))) 
Hex=Hexes[hull, ] #Subset Hexes to occur only within the convex hull containing the hair snare sites
Hex_df=fortify(Hex)
hull=gConvexHull(Points)
hull=spTransform(hull, CRS(proj4string(HexesMo)))
HexMo=HexesMo[hull, ] #Subset Hexes to occur only within the convex hull containing the hair snare sites
HexMo_df=fortify(HexMo)


leaflet(CAoutline) %>% 
  setView(-118.5, 38, 5) %>% 
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', 
           'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community') %>%
  addPolygons(color="gray50", opacity=1, weight=5) %>%
  #addPolygons(lng=c(-121.4167,-121.4167,-119.8617,-119.8617),lat=c(35.88504,34.84611,34.84611,35.88504), opacity=1, fillOpacity=1, color="black", fillColor="white", fill=T, weight=2) %>%
  addCircles(lng=NewPoints@coords[,1],lat=NewPoints@coords[,2], color="red", opacity=1, weight=1) %>%
  addPolylines(lng=Hex_df$long, lat=Hex_df$lat, group=NULL, color="black", opacity=1, weight=0.3) %>%
  addPolylines(lng=HexMo_df$long, lat=HexMo_df$lat, group=NULL, color="black", opacity=1, weight=0.3)
  #addPolygons(data=CAcounties, group=NULL, color="black", opacity=1, fill=F, weight=3) %>%
  #addPolygons(data=California, group=NULL, color="black", opacity=1, fill=F, weight=3) 

#Study site with details, tighter polygon:
proj4string(Points) = CRS("+init=EPSG:3857 +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
hull=gConvexHull(Points)
hull=spTransform(hull, CRS(proj4string(Hexes))) 
hull_df=fortify(hull)
Hex=Hexes[hull, ] #Subset Hexes to occur only within the convex hull containing the hair snare sites
Hex_df=fortify(Hex)

leaflet(us) %>% 
  setView(-118.5, 38, 5) %>% 
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', 
           'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community') %>%
  addPolygons(color="gray50", opacity=1, weight=5) %>%
  addPolygons(lng=hull_df$long,lat=hull_df$lat, opacity=1, fillOpacity=1, color="black", fillColor="white", fill=T, weight=3) %>%
  addCircles(lng=Points@coords[,1],lat=Points@coords[,2], color="red", opacity=1, weight=1) %>%
  addPolylines(lng=Hex_df$long, lat=Hex_df$lat, group=NULL, color="black", opacity=1, weight=0.3) %>%
  addPolylines(lng=HexMo_df$long, lat=HexMo_df$lat, group=NULL, color="black", opacity=1, weight=0.3)


#Study site with details, tighter polygon:
proj4string(Points) = CRS("+init=EPSG:3857 +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
Hex1=spTransform(Hexes, CRS(proj4string(Points))) 
Hex1_df=fortify(Hex1)
Hex2=Hex1[Points, ] #Subset Hexes to occur only within the convex hull containing the hair snare sites
Hex2_df=fortify(Hex2)

leaflet(us) %>% 
  setView(-118.5, 38, 5) %>% 
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', 
           'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community') %>%
  addPolygons(color="gray50", opacity=1, weight=5) %>%
  addPolygons(lng=hull_df$long,lat=hull_df$lat, opacity=1, fillOpacity=1, color="black", fillColor="white", fill=T, weight=2) %>%
  addCircles(lng=Points@coords[,1],lat=Points@coords[,2], color="red", opacity=1, weight=1) %>%
  addPolylines(lng=Hex2_df$long, lat=Hex2_df$lat, group=NULL, color="black", opacity=1, weight=0.3)






######Now trying to make the same map in ggmaps
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
CA=map2SpatialPolygons(outline,"CA", proj4string=CRS("+init=EPSG:3857 +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
CA_df=fortify(CA)
#make it into a bbox
sbbox=make_bbox(lon = CA_df$long, lat = CA_df$lat)
#Get a terrain background in black and white
spmap_T=get_map(location=sbbox, maptype=c("terrain-background"), source="stamen", color="bw", crop=T)


ggmap(spmap_T) +
  geom_path(data=CAco_df, aes(long,lat,group=group, fill=F)) +
  coord_quickmap(xlim=CA_df$long, ylim=CA_df$lat) +
  theme_opts  + 
  geom_point(data=NewPoints, aes(coords.x1,coords.x2, group=NULL, size=15),alpha = .8, colour="red") +
  geom_path(data=Hex2_df, aes(long,lat,group=group, fill=F)) +
  theme(legend.position="none")


#and the inset

#Confine it to Monterey and SLO counties  
CAco=CAcounty=map('county', c('california,monterey','california,san luis obispo'), fill=T)
CAco1=map2SpatialPolygons(CAco,IDs=c('california,monterey','california,solano'),proj4string=CRS("+init=EPSG:3857 +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
CAco_df=fortify(CAco1)

Hexes=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\Shape files 5-6-13\\Hex.shp", layer="Hex")
Hexes=spTransform(Hexes, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
Hexes_df=fortify(Hexes)
Points=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\Shape files 5-6-13\\points.shp", layer="points")
Points=spTransform(Points, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

proj4string(Points) = CRS("+init=EPSG:3857 +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
Points1=spTransform(Points, CRS(proj4string(CAco1))) 
Points2=Points1[CAco1, ]
mapdata=data.frame(Points2)
NewPoints=fortify(mapdata)

proj4string(Points2) = CRS("+init=EPSG:3857 +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") 
Hex1=spTransform(Hexes, CRS(proj4string(Points2))) 
Hex1_df=fortify(Hex1)
Hex2=Hex1[Points, ] #Subset Hexes to occur only within the convex hull containing the hair snare sites
Hex2_df=fortify(Hex2)


ggplot(Box, aes(lon,lat, group=NULL)) + 
  theme_opts + #Apply our themes from above
  geom_point(data=NewPoints, aes(coords.x1,coords.x2, group=NULL, size=15),alpha = .8, colour="red") +
  geom_path(data=Hex2_df, aes(long,lat,group=group, fill=F)) +
  theme(legend.position="none") +
  scaleBar(lon = -121.4, lat = 35, distanceLon = 30, distanceLat = 5, distanceLegend = 7, dist.unit = "km", orientation = FALSE, legend.size = 9) +
  geom_path(data=CAco_df, aes(long,lat,group=group, fill=F))


#and the inset
#Run ggmap_AddScalebar.R before executing this bit (it's in the R > Maps directory)

Box=data.frame(lon=c(-121.4167,-121.4167,-119.8617,-119.8617),lat=c(35.88504,34.84611,34.84611,35.88504))

ggplot(Box, aes(lon,lat, group=NULL)) + 
  theme_opts + #Apply our themes from above
  geom_point(data=NewPoints, aes(POINT_X,POINT_Y, group=NULL, size=15),alpha = .8, colour="red") +
  geom_path(data=Hex2_df, aes(long,lat,group=group, fill=F)) +
  theme(legend.position="none") +
  scaleBar(lon = -121.4, lat = 35, distanceLon = 30, distanceLat = 5, distanceLegend = 7, dist.unit = "km", orientation = FALSE, legend.size = 9)
