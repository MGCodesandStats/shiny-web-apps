library(shiny)

#Define UI for application
shinyUI(fluidPage(
  
  #Application title
  titlePanel("Maps"),
  
  #Sidebar with a slider input
  sidebarLayout(
    sidebarPanel(
      sliderInput("lat",
                  "Latitude:",
                  min = -100,
                  max = 100,
                  value = 1),
      sliderInput("long",
                  "Longitude:",
                  min = -200,
                  max = 200,
                  value = 1)
    ),
    
    #Show a plot of the map
    mainPanel(
      plotOutput("MapsOutput")
    )
    
  )
  
))