# Reference used as a guide: https://community.plotly.com/t/incorporate-a-plotly-graph-into-a-shiny-app/5329/2

library(shiny)
library(plotly)

brand<-c("Brand A", "Brand A", "Brand A", "Brand A", "Brand A", "Brand A", "Brand A", "Brand A", "Brand A", "Brand A", "Brand B", "Brand B", "Brand B", "Brand B", "Brand B",  "Brand B",  "Brand B",  "Brand B",  "Brand B",  "Brand B")
price<-c(82,
         87,
         55,
         60,
         70,
         89,
         39,
         51,
         35,
         85,
         132,
         94,
         71,
         56,
         76,
         106,
         63,
         130,
         52,
         145
)
quantity<-c(497,
            692,
            683,
            691,
            727,
            655,
            782,
            655,
            718,
            674,
            633,
            627,
            497,
            780,
            423,
            587,
            602,
            754,
            502,
            661
)
sales<-price*quantity
period<-c('1 Q1', '1 Q2', '1 Q3', '1 Q4', '2 Q1', '2 Q2', '2 Q3', '2 Q4', '3 Q1', '3 Q2', '1 Q1', '1 Q2', '1 Q3', '1 Q4', '2 Q1', '2 Q2', '2 Q3', '2 Q4', '3 Q1', '3 Q2')
data<-data.frame(price, quantity, sales, period)

ui <- fluidPage(
  h1('Sales Metrics'),
  h4('Hypothetical data created by author.'),
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
    plot1 <- plot_ly(
      x = x(),
      y = y(), 
      type = 'scatter',
      mode = 'markers',
      size = size(),
      color = ~brand,
      colors = 'Paired',
      marker = list(opacity = 0.5, sizemode = 'diameter'))
  )
  
}

shinyApp(ui,server)