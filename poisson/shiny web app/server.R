library(shiny)
library(ggplot2)
library(scales)

# Shiny Application
shinyServer(function(input, output) {
  
  # Reactive expressions
  output$ProbPlot <- renderPlot({
    
    # generate lambda based on input$lambda from ui.R
    l = input$l
    x <- 0:20
    
    # generate trials based on lambda value
    muCalculation <- function(x, lambda) {dpois(x, l=lambda)}
    probability_at_lambda <- sapply(input$x, muCalculation, seq(1, 20, 0.01))
    # draw the probability
    plot(x, dpois(x, l), type='h',lwd=3)
    title(main="Poisson Distribution")
  })
  
})