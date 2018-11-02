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
                  value = 0),
      sliderInput("long",
                  "Longitude:",
                  min = -200,
                  max = 200,
                  value = 0),
      sliderInput("latbound1",
                  "Latitude boundary 1:",
                  min = -100,
                  max = 100,
                  value = -100),
      sliderInput("longbound1",
                  "Longitude boundary 1:",
                  min = -200,
                  max = 200,
                  value = -200),
      sliderInput("latbound2",
                  "Latitude boundary 2:",
                  min = -100,
                  max = 100,
                  value = 100),
      sliderInput("longbound2",
                  "Longitude boundary 2:",
                  min = -200,
                  max = 200,
                  value = 200)
    ),
    
    #Show a plot of the map
    mainPanel(
      plotOutput("MapsOutput")
    )
    
  )
  
))
