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
California=readOGR(dsn="V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Map\\Bears - Jamie Sherman\\CAShapefiles\\State_With_County_Boundaries.shp", layer="State_With_County_Boundaries")
California=spTransform(California, CRS(proj4string(NewPoints)))
#CAcounties_df=fortify(CAcounties)

Box=data.frame(lon=c(-121.9812,-121.9812,-119.4726,-119.4726),lat=c(36.91976,34.89752,34.89752,36.91976))

leaflet(CAoutline) %>% 
  setView(-118.5, 38, 5) %>% 
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', 
           'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community') %>%
  addPolygons(color="gray50", opacity=1, weight=5) %>%
  addPolygons(data=CAcounties, group=NULL, color="black", opacity=1, fill=T, fillColor="white", fillOpacity=0.35, weight=3)  %>%
  addPolygons(data=California, color="black", opacity=1, weight=3)

#Other options to add to leaflet map
#%>% addPolygons(Box$lon, Box$lat, opacity=1, fillOpacity=1, color="black", fillColor="white", fill=T, weight=3) %>% #Box around the study site, if necessary...
#%>% addPolygons(data=Hexes, group=NULL, color="black", opacity=1, weight=0.3) %>%
#%>% addPolygons(data=HexesMo, group=NULL, color="black", opacity=1, weight=0.3) 
#%>% addCircles(lng=NewPoints@coords[,1],lat=NewPoints@coords[,2], stroke=T, color="gray75", fill="gray75",opacity=1, weight=3)


#and the inset
CAcounties_df=fortify(CAcounties)
Hexes_df=fortify(Hexes)
HexesMo_df=fortify(HexesMo)
mapdata=data.frame(NewPoints)
NewPoints_df=fortify(mapdata)

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

#and the inset
#Run ggmap_AddScalebar.R before executing this bit (it's in the R > Maps directory)

Box=data.frame(lon=c(-121.9812,-121.9812,-119.4726,-119.4726),lat=c(36.91976,34.89752,34.89752,36.91976))

p = ggplot(Box, aes(lon,lat, group=NULL)) + 
  theme_opts + #Apply our themes from above
  geom_path(data=HexesMo_df, aes(long,lat,group=group, fill=F)) +
  geom_path(data=Hexes_df, aes(long,lat,group=group, fill=F)) +
  geom_path(data=CAcounties_df, aes(long,lat,group=group, fill=F)) +
  geom_point(data=NewPoints_df, aes(Long, Lat, group=NULL),size=4, alpha = .8, colour="gray25") +
  theme(legend.position="none") +
  scaleBar(lon = -122.2, lat = 35, distanceLon = 40, distanceLat = 6, distanceLegend = 11, dist.unit = "km", orientation = FALSE, legend.size = 12)

ggsave("Inset_Final.png",p,width=400,height=350, units="mm", dpi=200)


#Study site with a convex hull over the points.:
hull=gConvexHull(NewPoints)

leaflet(CAoutline) %>% 
  setView(-118.5, 38, 5) %>% 
  addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', 
           'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community') %>%
  #addPolygons(Box$lon, Box$lat, opacity=1, fillOpacity=1, color="black", fillColor="white", fill=T, weight=3) %>% #Box around the study site, if necessary...
  addPolygons(color="gray50", opacity=1, weight=5) %>%
  addPolygons(data=hull, group=NULL, color="black", opacity=1, fill=T, fillColor="white", fillOpacity=0.3, weight=3) %>%
  addPolygons(data=Hexes, group=NULL, color="black", opacity=1, weight=0.3) %>%
  addPolygons(data=HexesMo, group=NULL, color="black", opacity=1, weight=0.3) %>%
  addCircles(lng=NewPoints@coords[,1],lat=NewPoints@coords[,2], color="gray50", opacity=1, weight=3)

