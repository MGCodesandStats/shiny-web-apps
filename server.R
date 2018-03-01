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
    l2=0:1
    lambda2 <- seq(min(l2), max(l2), length.out = input$lambda2)
    probability=lambda
    l3=0:1
    lambda3 <- seq(min(l3), max(l3), length.out = input$lambda3)
    probability=lambda
    
    # generate trials based on lambda value
    muCalculation <- function(lambda, powers) {1 - ((1 - lambda)^powers)}
    probability_at_lambda <- sapply(input$lambda, muCalculation, seq(0, 100, 10))
    probability_at_lambda2 <- sapply(input$lambda2, muCalculation, seq(0, 100, 10))
    probability_at_lambda3 <- sapply(input$lambda3, muCalculation, seq(0, 100, 10))
    
    # draw the probability
    par(bg = '#191661', fg = '#ffffff', col.main = '#ffffff', col.lab = '#ffffff', col.axis = '#ffffff')
    plot(probability_at_lambda, type = "o", col = 'white', border = 'white', xlab="N", ylab ="Probability 1", ylim=c(0.0, 1.0))
    lines(probability_at_lambda2,type="o",col="red", xlab="N", ylab="Probability 2", ylim=c(0.0, 1.0))
    lines(probability_at_lambda3,type="o",col="green", xlab="N", ylab="Probability 3", ylim=c(0.0, 1.0))
    title(main="Cumulative Binomial Probability Plot")
  })
  
})
