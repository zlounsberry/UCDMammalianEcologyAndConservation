library(shiny)
library(leaflet)
library(spatstat)
library(raster)
library(rgdal)
library(fifer)

#setwd("C:/Users/Zach/Documents/EMBARK/TestMapApp/MapTestApp")
setwd("./data")

shinyServer(function(input, output) {
  points = eventReactive(input$var, {
    FakeCluster=read.csv("./FakeData.csv", header=T)
    Species=input$var
    SpeciesColumn=which(colnames(FakeCluster)==Species)
    toVary=FakeCluster[,SpeciesColumn]
    longRange = FakeCluster$Long
    latRange = FakeCluster$Lat
    Dens = data.frame(longRange,latRange,toVary, row.names=FakeCluster[,1])
    Dens = Dens[complete.cases(Dens),]
    Dens$toVary=Dens$toVary - min(Dens$toVary)
    Dens$toVary=Dens$toVary/(max(Dens$toVary))
    cbind(Dens$longRange,Dens$latRange)
  })
  Raster = eventReactive(input$var, {
    FakeCluster=read.csv("./FakeData.csv", header=T)
    Species=input$var
    SpeciesColumn=which(colnames(FakeCluster)==Species)
    toVary=FakeCluster[,SpeciesColumn]
    longRange = FakeCluster$Long
    latRange = FakeCluster$Lat
    Dens = data.frame(longRange,latRange,toVary, row.names=FakeCluster[,1])
    Dens = Dens[complete.cases(Dens),]
    Dens$toVary=Dens$toVary - min(Dens$toVary)
    Dens$toVary=Dens$toVary/(max(Dens$toVary))
    CA = map('state', regions="California", plot=F, fill=T)
    IDs = sapply(strsplit(CA$names, ":"), function(x) x[1])
    CA.poly = map2SpatialPolygons(CA, IDs = IDs)
    xWin = as.owin.SpatialPolygons(CA.poly)
    pts <- as.ppp(Dens,W=xWin)
    pt.dens = density(pts,weights=pts$marks, sigma=10, eps=0.05)
    surface = raster(pt.dens)
    crs(surface) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
    surface=projectRasterForLeaflet(surface)
    surface
  })
  col = eventReactive(input$var, {
    FakeCluster=read.csv("./FakeData.csv", header=T)
    Species=input$var
    SpeciesColumn=which(colnames(FakeCluster)==Species)
    colors=string.to.color(colnames(FakeCluster[1:8]))
    col1 = colors[SpeciesColumn]
    colorRampPalette(c("transparent", col1), alpha=T)( 100 )
  })
  col1 = eventReactive(input$var, {
    FakeCluster=read.csv("./FakeData.csv", header=T)
    Species=input$var
    SpeciesColumn=which(colnames(FakeCluster)==Species)
    colors=string.to.color(colnames(FakeCluster[1:8]))
    colors[SpeciesColumn]
  })
  output$mymap <- renderLeaflet({
    leaflet() %>% 
      setView(-118.5, 38, 5) %>%
      addTiles('http://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png', 
               '&copy; <a href="http://www.opencyclemap.org">OpenCycleMap</a>, &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
      addCircles(data=points(), weight = 6, radius=40, color=col1(), stroke = TRUE, fillOpacity = 0.9) %>%
      addRasterImage(Raster(), colors = col(), project=F)
  })
})
