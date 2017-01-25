library(shiny)
library(leaflet)
setwd("./data")

FakeCluster=read.csv("./FakeData.csv", header=T)

  shinyUI(fluidPage(titlePanel("Mysterious Dots and Surfaces?"), leafletOutput("mymap"),
                 sidebarLayout(sidebarPanel(helpText("What species?")),
                               selectInput("var",label = "Choose a species",
                                           choices = colnames(FakeCluster[4:8])))))