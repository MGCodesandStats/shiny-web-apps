# Reference: https://community.plotly.com/t/incorporate-a-plotly-graph-into-a-shiny-app/5329/2

library(shiny)
library(plotly)

# Data sourced from: https://www.ihgplc.com/~/media/Files/I/Ihg-Plc/investors/results/2023/q3-2023/ihg-q3-trading-update-2023-supplementary-information-v2.pdf

brand<-c("InterContinental","Kimpton","Hotel Indigo","Crowne Plaza","EVEN Hotels","Holiday Inn Express","Holiday Inn","Staybridge Suites","Candlewood Suites")
adr<-c(230.53,256.93,186.12,141.82,166.60,136.76,132.08,136.38,103.21)
revpar<-c(153.69,185.64,130.36,92.46,120.28,101.24,88.93,108.32,79.84)
occupancy<-c(66.7,72.3,70.0,65.2,72.2,74.0,67.3,79.4,77.4)
rooms<-c(15694,10886,9685,27392,2744,227533,111835,31225,33156)
data<-data.frame(revpar,adr,occupancy,rooms)

ui <- fluidPage(
  h1('IHG Q3 2023: Hotel Metrics'),
  h4('The purpose of this visualisation is to allow users to analyse key hotel KPIs across IHG hotel brands. Data sourced from IHG Q3 2023 earnings report.'),
  h5('ADR = Average Daily Rate, RevPAR = Revenue per available room.'),
  a("IHG Q3 2023 earnings data available here", href="https://www.ihgplc.com/~/media/Files/I/Ihg-Plc/investors/results/2023/q3-2023/ihg-q3-trading-update-2023-supplementary-information-v2.pdf"),
  h5(''),
  sidebarPanel(
    selectInput('xcol','X Variable', names(data)),
    selectInput('ycol','Y Variable', names(data)),
    selectInput('sizecol','Bubble Size', names(data)),
    selected = names(data)[[2]]),
  mainPanel(
    plotlyOutput('plot')
  )
)

server <- function(input, output) {
  
  x <- reactive({
    data[,input$xcol]
  })
  
  y <- reactive({
    data[,input$ycol]
  })
  
  size <- reactive({
    data[,input$sizecol]
  })
  
  
  output$plot <- renderPlotly(
  p <- plot_ly(
    x = x(), 
    y = y(),  
    type = 'scatter', 
    mode = 'markers', 
    size = size(),
    color = ~brand, 
    colors = 'Paired',
    marker = list(opacity = 0.5, sizemode = 'diameter')))
}

shinyApp(ui,server)
