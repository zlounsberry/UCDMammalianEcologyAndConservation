setwd("V:\\3730Data\\377STRs\\Wildlife\\R Scripts\\R Stuff\\Leaflet")
library(shiny)
library(leaflet)
library(spatstat)
library(raster)
library(rgdal)
library(fifer)
library(maps)
library(maptools)

###First, let's make a simple map with points representing made-up species data for 3 cities in CA:

FakeCluster=read.csv("./FakeData.csv", header=T)

server = function(input, output) { #Makes your server object for interactive data
  points = eventReactive(input$var, { #Specifies the points that each interactive value will produce on your map
    FakeCluster=read.csv("./FakeData.csv", header=T) #Read in your data 
    Species=input$var #input$var is defined by you as the input variable you want to be able to change. Here: species
    SpeciesColumn=which(colnames(FakeCluster)==Species) #Find which column has your species and make this column number an object
    toVary=FakeCluster[,SpeciesColumn] #Pull just this column containing your spp. into an object
    longRange = FakeCluster$Long #Pull longitude values for rows into a file
    latRange = FakeCluster$Lat #Pull lats in
    Dens = data.frame(longRange,latRange,toVary, row.names=FakeCluster[,1]) #Make a new data frame containing your longitude, latitude, species counts (for the spp you are currently looking at), and the city names
    Dens = Dens[complete.cases(Dens),] #Remove the cities that do not contain data for your species
    cbind(Dens$longRange,Dens$latRange) #This bit, importantly, prints everything you just did such that the "points" function is printed as this
  })
output$mymap <- renderLeaflet({ #render the map that will be fed into the shiny server. The UI object (below) is the user interface object that we will use to interact with our map
  leaflet() %>% #Make a blank leaflet map
    setView(-118.5, 38, 5) %>% #zoom it in on CA
    addTiles('http://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png', 
             '&copy; <a href="http://www.opencyclemap.org">OpenCycleMap</a>, &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% #This bit sets your tiles If you don't like these tiles, go to http://leaflet-extras.github.io/leaflet-providers/preview/ and replace the tileLayer and attribution fields to whatever you like!
    addCircles(data=points(), weight = 9, radius=40, color="yellow", stroke = TRUE, fillOpacity = 0.9) #plot your points. Important! You need to set your data as "points()" not "points" or it won't know you want to pull your reactive function you just made
})
}

ui = fluidPage(titlePanel("Where are my target species?"), leafletOutput("mymap"), #The user interface (UI) is a dynamic html page. The output should be the map/reactive points you made above (here: "mymap")
               sidebarLayout(sidebarPanel(helpText("Which species?")), #Set the title of the sidebar
                             selectInput("var",label = "Choose a species", #important! "var" is what you set as input$var above. This needs to match your reactive values exactly to work
                                         choices = colnames(FakeCluster[4:8])))) #These are your input$var values that you defined in the server

shinyApp(ui, server) #run it! Should host an html object in your web browser of choice. If this browser is IE, reconsider.
  
  


###Well, those are all the same, so how about we change the colors for each spp?

FakeCluster=read.csv("./FakeData.csv", header=T)

server = function(input, output) { 
  points = eventReactive(input$var, { 
    FakeCluster=read.csv("./FakeData.csv", header=T) 
    Species=input$var 
    SpeciesColumn=which(colnames(FakeCluster)==Species) 
    toVary=FakeCluster[,SpeciesColumn] 
    longRange = FakeCluster$Long 
    latRange = FakeCluster$Lat 
    Dens = data.frame(longRange,latRange,toVary, row.names=FakeCluster[,1]) 
    Dens = Dens[complete.cases(Dens),] 
    cbind(Dens$longRange,Dens$latRange) 
  })
  col1 = eventReactive(input$var, {
    FakeCluster=read.csv("./FakeData.csv", header=T) #Read in data again (still not 100% you have to do this every time, but I think it wasn't working for me when I didn't...)
    Species=input$var
    SpeciesColumn=which(colnames(FakeCluster)==Species)
    colors=c("black","green","purple","white","red","pink","yellow") #addCircles doesn't seem to like string.to.color's hex output, so I am making them by hand...
    colors[SpeciesColumn] #This takes the SpeciesColumn'th value in the color object and makes "col1()" represent that color, which is now reactive to your spp of interest.
    })
  output$mymap <- renderLeaflet({
    leaflet() %>% 
      setView(-118.5, 38, 5) %>%
      addTiles('http://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png', 
               '&copy; <a href="http://www.opencyclemap.org">OpenCycleMap</a>, &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
      addCircles(data=points(), weight = 6, color=col1(), stroke = TRUE, fillOpacity = 0.9) #Note the change to color=col1()
  })
}

ui = fluidPage(titlePanel("Where are my target species?"), leafletOutput("mymap"),
               sidebarLayout(sidebarPanel(helpText("Which species?")),
                             selectInput("var",label = "Choose a species",
                                         choices = colnames(FakeCluster[4:8]))))

shinyApp(ui, server)



###Not bad, but still a bit hard to see (on purpose... it's a demonstration. relax already!). Plus, we want to know how many are at each spot, right?
###How about we add a raster layer to it so that we can get a feel for the distribution a bit better? 

FakeCluster=read.csv("./FakeData.csv", header=T)

server = function(input, output) { 
  points = eventReactive(input$var, { 
    FakeCluster=read.csv("./FakeData.csv", header=T) 
    Species=input$var 
    SpeciesColumn=which(colnames(FakeCluster)==Species) 
    toVary=FakeCluster[,SpeciesColumn] 
    longRange = FakeCluster$Long 
    latRange = FakeCluster$Lat 
    Dens = data.frame(longRange,latRange,toVary, row.names=FakeCluster[,1]) 
    Dens = Dens[complete.cases(Dens),] 
    cbind(Dens$longRange,Dens$latRange) 
  })
  col1 = eventReactive(input$var, {
    FakeCluster=read.csv("./FakeData.csv", header=T) #Read in data again (still not 100% you have to do this every time, but I think it wasn't working for me when I didn't...)
    Species=input$var
    SpeciesColumn=which(colnames(FakeCluster)==Species)
    colors=c("","","black","green","purple","white","red","pink","yellow") #addCircles doesn't seem to like string.to.color's hex output, so I am making them by hand...
    colors[SpeciesColumn] #This takes the SpeciesColumn'th value in the color object and makes "col1()" represent that color, which is now reactive to your spp of interest.
  })
    Raster = eventReactive(input$var, { #time to make a raster layer!
      FakeCluster=read.csv("./FakeData.csv", header=T) 
      Species=input$var
      SpeciesColumn=which(colnames(FakeCluster)==Species)
      toVary=FakeCluster[,SpeciesColumn]
      longRange = FakeCluster$Long
      latRange = FakeCluster$Lat
      Dens = data.frame(longRange,latRange,toVary, row.names=FakeCluster[,1])
      Dens = Dens[complete.cases(Dens),]
      Dens$toVary=Dens$toVary - min(Dens$toVary) #Adjusting to make a cleaner density surface, first remove the min value of the columm
      Dens$toVary=Dens$toVary/(max(Dens$toVary)) #Then get a ratio of each value relative to the max value... RK did this, not actually 100% why it works yet but it works!
      xWin = c(-130, -110, 30, 42) #Make a box around CA by defining bordering lats/longs (rough, here)
      pts <- as.ppp(Dens,W=xWin) #Turn the Dens object into a ppp object for spatstat, confined to the window around CA you just made
      pt.dens = density(pts,weights=pts$marks, sigma=5, eps=0.05) #Turn this ppp object into a density surface. Sigma will be your distance from points and epsilon will be your smoothing (smaller epsilon = smoother (but bigger!))
      surface = raster(pt.dens) #Turn this density surface into a raster layer
      crs(surface) = sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs") #Define the blank raster layer with the appropriate projection, ellipses, etc. for Leaflet
      surface=projectRasterForLeaflet(surface) #Re-project the data for leaflet using this function from Leaflet
      surface #make sure Raster() is defined as this new surface (for rendering below)
    })
    col = eventReactive(input$var, { #This will define the color for the raster layer
      FakeCluster=read.csv("./FakeData.csv", header=T)
      Species=input$var
      SpeciesColumn=which(colnames(FakeCluster)==Species)
      colors=string.to.color(colnames(FakeCluster[1:8])) #Raster is cool with hex codes, so string.to.color works here
      col1 = colors[SpeciesColumn] #The SpeciesColumn'th color
      colorRampPalette(c("transparent", col1), alpha=T)( 100 ) #Define col() as the color ranging from transparent (for low/missing density, so the whole map isn't covered...) to your predefined colors.
    })
  output$mymap <- renderLeaflet({
    leaflet() %>% 
      setView(-118.5, 38, 5) %>%
      addTiles('http://{s}.tile.thunderforest.com/transport-dark/{z}/{x}/{y}.png', 
               '&copy; <a href="http://www.opencyclemap.org">OpenCycleMap</a>, &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
      addCircles(data=points(), weight = 6, color="black", stroke = TRUE, fillOpacity = 0.9) %>% 
      addRasterImage(Raster(), colors = col(), project=F) #add the layer using Raster() and col() defined above. No need to project it, it's already projected (and writing it this way is easier than having it project the raster after the fact)
    })
}

ui = fluidPage(titlePanel("Where are my target species?"), leafletOutput("mymap"),
               sidebarLayout(sidebarPanel(helpText("Which species?")),
                             selectInput("var",label = "Choose a species",
                                         choices = colnames(FakeCluster[4:8]))))

shinyApp(ui, server)





###Better! But that box is ugly... So I'm going to confine it to just CA using the map() function in the 'maps' package to define the window for density surface

FakeCluster=read.csv("./FakeData.csv", header=T)

server = function(input, output) {
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
}

ui = fluidPage(titlePanel("Mysterious Dots and Surfaces?"), leafletOutput("mymap"),
               sidebarLayout(sidebarPanel(helpText("What species?")),
                             selectInput("var",label = "Choose a species",
                                         choices = colnames(FakeCluster[4:8]))))

shinyApp(ui, server)


#############################################################################

##"Cool" you are probably thinking to yourself... "But how do I do this with real data??"
##See: below... sorry, not quite annotated yet...


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
    output$mymap <- renderLeaflet({
      leaflet() %>% 
        setView(-121,38,6) %>%
        addTiles('http://korona.geog.uni-heidelberg.de/tiles/roads/x={x}&y={y}&z={z}', 
                 attribution='Imagery from <a href="http://giscience.uni-hd.de/">GIScience Research Group @ University of Heidelberg</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
        addMarkers(data=points(), popup = ~paste(sep="","Lat = ",Lat,", Long = ",Lon, ", Collector = ",Collector)) #Consider making this "collected by... variable"
    })
  })