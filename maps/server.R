library(shiny)
library(ggplot2)
library(scales)
require(maps)
require(mapdata)
library(ggrepel)

#Shiny Application
shinyServer(function(input,output) {
  
  #Reactive expressions
  output$MapsOutput <- renderPlot({
    
    #generate lambda based on input$lambda from ui.R
    lat=-100:100
    long=-200:200
    locations = c("My Location")
    
    global <- map_data("world")
    ggplot() + geom_polygon(data = global, aes(x=long, y = lat, group = group)) + 
      coord_fixed(1.3)
    
    ggplot() + 
      geom_polygon(data = global, aes(x=long, y = lat, group = group), fill = NA, color = "black") + 
      coord_fixed(1.3)
    
    gg1 <- ggplot() + 
      geom_polygon(data = global, aes(x=long, y = lat, group = group), fill = "green", color = "blue") + 
      coord_fixed(1.3) + scale_x_continuous(breaks = seq(-200, 200, 20)) + scale_y_continuous(breaks = seq(-100, 100, 10))
    gg1
    
    boundaries <- data.frame(
      latbound1 = input$latbound1,
      longbound1 = input$longbound1,
      latbound2 = input$latbound2,
      longbound2 = input$longbound2,
      stringsAsFactors = FALSE
    )
    
    coors <- data.frame(
      lat = input$lat,
      long = input$long,
      stringsAsFactors = FALSE
    )  
    
    #xlim and ylim can be manipulated to zoom in or out of the map
    coors$locations <- locations
    gg1 + 
      geom_point(data=coors, aes(long, lat), colour="red", size=2) + 
      ggtitle("World Map") +
      geom_text_repel(data=coors, aes(long, lat, label=locations)) + xlim(input$longbound1,input$longbound2) + ylim(input$latbound1,input$latbound2)
    
  })
  
})
