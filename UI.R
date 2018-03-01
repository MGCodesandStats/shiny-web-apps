library(shiny)

# Define UI for application that draws a probability plot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Cumulative Binomial Probability Plot"),
  
  # Sidebar with a slider input for value of lambda
  sidebarLayout(
    sidebarPanel(
      sliderInput("lambda",
                  "Probability of event occuring in a single trial:",
                  min = 0,
                  max = 1,
                  value = 0.01)
    ),
    
    # Show a plot of the generated probability plot
    mainPanel(
      plotOutput("ProbPlot")
    )
  )
))
