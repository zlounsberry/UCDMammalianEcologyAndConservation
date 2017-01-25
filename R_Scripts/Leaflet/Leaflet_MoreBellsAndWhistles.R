setwd("V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Leaflet")
library(leaflet)
library(shiny)
library(spatstat)
library(raster)
library(rgdal)
library(fifer)

MeanClusterByGeography=read.csv("SacValleyFoxes.csv", header=T)
colors=string.to.color(colnames(MeanClusterByGeography[4:10]))
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

###Going to try to make the circles work before the raster image.

shinyApp(
  ui = fluidPage(titlePanel("Species Sightings in the Valley"), leafletOutput("mymap"),
                 sidebarLayout(sidebarPanel(helpText("Please Select a species of interest")),
                               selectInput("var",label = "Species",
                                           choices = as.vector(unique(MeanClusterByGeography[,10]))))),
  server = function(input, output) {
    points = eventReactive(input$var, {
      MeanClusterByGeography=read.csv("SacValleyFoxes.csv", header=T)
      Species=input$var
      SpeciesRow = which(MeanClusterByGeography[,10]==Species)
      Dens = MeanClusterByGeography[SpeciesRow,]
      Dens
    })
    col1 = eventReactive(input$var, {
      MeanClusterByGeography=read.csv("SacValleyFoxes.csv", header=T)
      Species=input$var
      colors = string.to.color(as.vector(unique(MeanClusterByGeography[,10])))
      colors[which(as.vector(unique(MeanClusterByGeography[,10]))==Species)]
    })
   # popup = eventReactive(input$var2, {
    #  MeanClusterByGeography=read.csv("SacValleyFoxes.csv", header=T)
     # Collector=input$var2
  #})
output$mymap <- renderLeaflet({
      leaflet() %>% 
        setView(-121,38,6) %>%
        addTiles('http://korona.geog.uni-heidelberg.de/tiles/roads/x={x}&y={y}&z={z}', 
                 attribution='Imagery from <a href="http://giscience.uni-hd.de/">GIScience Research Group @ University of Heidelberg</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>%  
        #addMarkers(data=points(), popup = ~paste(sep='',"Lat=",Lat,", Long=",Lon,'\nCollector=',Collector)) #Consider making this "collected by... variable"
        addMarkers(data=points(), popup = ~paste(sep="","Lat = ",Lat,", Long = ",Lon, ", Collector = ",Collector)) #Consider making this "collected by... variable"      
  #addCircles(data=points(), weight = 6, radius=40, color=col1(), stroke = TRUE, fillOpacity = 0.5) 
      })
  })