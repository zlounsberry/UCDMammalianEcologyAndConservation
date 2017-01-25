setwd("V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Leaflet\\TuleElk")
library(shiny)
library(leaflet)
library(spatstat)
library(raster)
library(rgdal)
library(fifer)
library(maps)
library(maptools)

FakeCluster=read.csv("./ElkTest.csv", header=T)
AgeClass="COW"
AgeClassColumn=which(colnames(FakeCluster)==AgeClass)
toVary=FakeCluster[,AgeClassColumn]
longRange = FakeCluster$X
latRange = FakeCluster$Y
CowDens = data.frame(longRange,latRange,toVary, row.names=NULL)
CowDens = CowDens[complete.cases(CowDens),]
CowDens$toVary=CowDens$toVary - min(CowDens$toVary)
CowDens$toVary=CowDens$toVary/(max(CowDens$toVary))
CowDens$toVary=CowDens$toVary*10
xWin = owin(c(-124.2,-121.3),c(37.9,40.6))
pts <- as.ppp(CowDens,W=xWin)
pt.CowDens = density(pts,weights=pts$marks, sigma=0.1, eps=0.005)
surface = raster(pt.CowDens)
crs(surface) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
surface1=projectRasterForLeaflet(surface)
col1=colorRampPalette(c("transparent", "white"), alpha=T)( 30 )

AgeClass="CALF"
AgeClassColumn=which(colnames(FakeCluster)==AgeClass)
toVary=FakeCluster[,AgeClassColumn]
longRange = FakeCluster$X
latRange = FakeCluster$Y
CalfDens = data.frame(longRange,latRange,toVary, row.names=NULL)
CalfDens = CalfDens[complete.cases(CalfDens),]
CalfDens$toVary=CalfDens$toVary - min(CalfDens$toVary)
CalfDens$toVary=CalfDens$toVary/(max(CalfDens$toVary))
CalfDens$toVary=CalfDens$toVary*10
xWin = owin(c(-124.2,-121.3),c(37.9,40.6))
pts <- as.ppp(CalfDens,W=xWin)
pt.CalfDens = density(pts,weights=pts$marks, sigma=0.1, eps=0.005)
surface = raster(pt.CalfDens)
crs(surface) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
surface2=projectRasterForLeaflet(surface)
col2=colorRampPalette(c("transparent", "red"), alpha=T)( 30 )

AgeClass="BULL"
AgeClassColumn=which(colnames(FakeCluster)==AgeClass)
toVary=FakeCluster[,AgeClassColumn]
longRange = FakeCluster$X
latRange = FakeCluster$Y
BullDens = data.frame(longRange,latRange,toVary, row.names=NULL)
BullDens = BullDens[complete.cases(BullDens),]
BullDens$toVary=BullDens$toVary - min(BullDens$toVary)
BullDens$toVary=BullDens$toVary/(max(BullDens$toVary))
BullDens$toVary=BullDens$toVary*10
xWin = owin(c(-124.2,-121.3),c(37.9,40.6))
pts <- as.ppp(BullDens,W=xWin)
pt.BullDens = density(pts,weights=pts$marks, sigma=0.1, eps=0.005)
surface = raster(pt.BullDens)
crs(surface) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
surface3=projectRasterForLeaflet(surface)
col3=colorRampPalette(c("transparent", "darkgreen"), alpha=T)( 30 )

  leaflet() %>% 
    setView(-118.5, 38, 5) %>%
    addTiles('http://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
             attribution='Map data: &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>, <a href="http://viewfinderpanoramas.org">SRTM</a> | Map style: &copy; <a href="https://opentopomap.org">OpenTopoMap</a> (<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA</a>') %>%
    addCircles(CowDens$longRange, CowDens$latRange, weight = CowDens$toVary, color="black", stroke = TRUE, fillOpacity = 0.9) %>%
    addCircles(BullDens$longRange, BullDens$latRange, weight = BullDens$toVary, color="black", stroke = TRUE, fillOpacity = 0.9) %>%
    addCircles(CalfDens$longRange, CalfDens$latRange, weight = CalfDens$toVary, color="black", stroke = TRUE, fillOpacity = 0.9) %>%
    addRasterImage(surface1, colors = col1, project=F) %>%
    addRasterImage(surface2, colors = col2, project=F) %>%
    addRasterImage(surface3, colors = col3, project=F)


###########################################################################
  
  
#Confining to EMUs - IN PROGRESS, doesn't work yet.
  FakeCluster=read.csv("./ElkTest.csv", header=T)
  AgeClass="BULL"
  AgeClassColumn=which(colnames(FakeCluster)==AgeClass)
  toVary=FakeCluster[,AgeClassColumn]
  longRange = FakeCluster$X
  latRange = FakeCluster$Y
  Dens = data.frame(longRange,latRange,toVary, row.names=NULL)
  Dens = Dens[complete.cases(Dens),]
  Dens$toVary=Dens$toVary - min(Dens$toVary)
  Dens$toVary=Dens$toVary/(max(Dens$toVary))
  Dens$toVary=Dens$toVary*10
#  Line = readShapeLines("V:/3730Data/377STRs/Wildlife/Lake & Colusa Tule Elk Project/Tule GIS/shapefiles, layers, etc/CDFW Elk Hunt Zones/BearValleyEMU")
  Line = readShapePoly("V:/3730Data/377STRs/Wildlife/Lake & Colusa Tule Elk Project/Tule GIS/shapefiles, layers, etc/CDFW Elk Hunt Zones/CacheCreekEMU", proj4string=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
  #crs(Line) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  Line = projectRasterForLeaflet(Line)
  xWin=as.owin.SpatialPolygons(Line)
  pts <- as.ppp(Dens,W=xWin)
  pt.dens = density(pts,weights=pts$marks, sigma=0.1, eps=0.005)
  surface = raster(pt.dens)
  crs(surface) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  surface1=projectRasterForLeaflet(surface)
  col1=colorRampPalette(c("transparent", "yellow"), alpha=T)( 30 )
  
  leaflet(Dens) %>% 
    setView(-118.5, 38, 5) %>%
    addTiles('http://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png', 
             '&copy; <a href="http://www.opencyclemap.org">OpenCycleMap</a>, &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
    addCircles(Dens$longRange, Dens$latRange, weight = ~toVary, radius=40, color="red", stroke = TRUE, fillOpacity = 0.9) %>%
    addRasterImage(surface1, colors = col1, project=F)









##"Cool" you are probably thinking to yourself... "But how do I do this with real data??"
##See: below... sorry, not quite annotated yet...


setwd("V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Leaflet")
library(leaflet)
library(shiny)
library(spatstat)
library(raster)
library(rgdal)
library(fifer)

MeanClusterByGeography=read.csv("ElkTest.csv", header=T)
colors=string.to.color(colnames(MeanClusterByGeography[6:8]))
col=colorRampPalette(c("transparent", "black"), alpha=T)( 70 )
toVary=MeanClusterByGeography[,10]
longRange = MeanClusterByGeography$Lon
latRange = MeanClusterByGeography$Lat
Dens = data.frame(longRange,latRange,toVary, row.names=MeanClusterByGeography[,2])
xWin=owin(c(-179,179),c(-89,89))
pts <- as.ppp(Dens,W=xWin)



#tiles: http://leaflet-extras.github.io/leaflet-providers/preview/
leaflet(Dens) %>% 
  setView(-121,38,6) %>%
  addTiles('http://korona.geog.uni-heidelberg.de/tiles/roads/x={x}&y={y}&z={z}', 
           attribution='Imagery from <a href="http://giscience.uni-hd.de/">GIScience Research Group @ University of Heidelberg</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>%
  addCircles(~longRange, ~latRange, weight = 6, radius=40, 
             color="blue", stroke = TRUE, fillOpacity = 0.5) 

shinyApp(
  ui = fluidPage(titlePanel("AgeClass Sightings in the Valley"), leafletOutput("mymap"),
                 sidebarLayout(sidebarPanel(helpText("Please Select a AgeClass of interest")),
                               selectInput("var",label = "AgeClass",
                                           choices = as.vector(unique(MeanClusterByGeography[,10]))))),
  server = function(input, output) {
    points = eventReactive(input$var, {
      MeanClusterByGeography=read.csv("ElkTest.csv", header=T)
      AgeClass=input$var
      AgeClassRow = which(MeanClusterByGeography[,10]==AgeClass)
      Dens = MeanClusterByGeography[AgeClassRow,]
      Dens
    })
    col1 = eventReactive(input$var, {
      MeanClusterByGeography=read.csv("ElkTest.csv", header=T)
      AgeClass=input$var
      colors = string.to.color(as.vector(unique(MeanClusterByGeography[,10])))
      colors[which(as.vector(unique(MeanClusterByGeography[,10]))==AgeClass)]
    })
    output$mymap <- renderLeaflet({
      leaflet() %>% 
        setView(-121,38,6) %>%
        addTiles('http://korona.geog.uni-heidelberg.de/tiles/roads/x={x}&y={y}&z={z}', 
                 attribution='Imagery from <a href="http://giscience.uni-hd.de/">GIScience Research Group @ University of Heidelberg</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
        addMarkers(data=points(), popup = ~paste(sep="","Lat = ",Lat,", Long = ",Lon, ", Collector = ",Collector)) #Consider making this "collected by... variable"
    })
  })