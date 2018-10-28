library(shiny)

#Define UI
ui<-fluidPage(
  titlePanel("Currency"),
  
  fluidRow(
    column(3,
           selectInput("symbols",
                       h3("Currency Symbols"),
                       choices = c("CAD/USD" = "FRED/DEXCAUS",
                                   "JPY/USD" = "FRED/DEXJPUS",
                                   "CHFUSD" = "FRED/DEXSZUS"),
                       selected="CAD/USD")),
    column(3,
           dateInput("start_date",
                     h3("Start Date"),
                     value="2016-05-01")),
    column(3,
           dateInput("end_date",
                     h3("End Date"),
                     value="2017-05-01"))
  ),
  
  #Show a plot of the generated output
  mainPanel(
    plotOutput("FXResults")
  )
)