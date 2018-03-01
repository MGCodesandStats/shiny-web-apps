library(shiny)

# Define UI for application that draws a probability plot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Cumulative Binomial Probability Plot"),
  
  # Sidebar with a slider input for value of lambda
  sidebarLayout(
    sidebarPanel(
      sliderInput("lambda",
                  "Probability 1:",
                  min = 0,
                  max = 0.1,
                  value = 0.01),
      sliderInput("lambda2",
                  "Probability 2:",
                  min = 0,
                  max = 0.1,
                  value = 0.01),
      sliderInput("lambda3",
                  "Probability 3:",
                  min = 0,
                  max = 0.1,
                  value = 0.01)
    ),
    
    # Show a plot of the generated probability plot
    mainPanel(
      plotOutput("ProbPlot")
    )
  )
))
