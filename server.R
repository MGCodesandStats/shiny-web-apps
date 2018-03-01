library(shiny)
library(ggplot2)
library(scales)

# Shiny Application
shinyServer(function(input, output) {
  
  # Reactive expressions
  output$ProbPlot <- renderPlot({
    
    # generate lambda based on input$lambda from ui.R
    l=0:1
    lambda <- seq(min(l), max(l), length.out = input$lambda)
    probability=lambda
    
    # generate trials based on lambda value
    muCalculation <- function(lambda, powers) {1 - ((1 - lambda)^powers)}
    probability_at_lambda <- sapply(input$lambda, muCalculation, seq(0, 100, 10))
    
    # draw the probability
    plot(probability_at_lambda, type = "o", col = 'blue', border = 'white', xlab="N", ylab ="Probability of occurence")
  })
  
})
