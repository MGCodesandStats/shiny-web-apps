# 1. Libraries and names_lists

library(shiny)
library(plotly)

values1 <- paste(c('Hilton', 'Hyatt', 'Marriott'))

names_hilton=c('revpar_hilton', 'adr_hilton', 'occupancy_hilton', 'rooms_hilton')
names_hyatt=c('revpar_hyatt', 'adr_hyatt', 'occupancy_hyatt', 'rooms_hyatt')
names_marriott=c('revpar_marriott', 'adr_marriott', 'occupancy_marriott', 'rooms_marriott')
A<-c("Waldorf Astoria Hotels & Resorts","LXR Hotels & Resorts","Conrad Hotels & Resorts","Canopy by Hilton","Hilton Hotels & Resorts","Curio Collection by Hilton","DoubleTree by Hilton","Tapestry Collection by Hilton","Embassy Suites by Hilton","Hilton Garden Inn","Hampton by Hilton","Tru by Hilton","Homewood Suites by Hilton","Home2 Suites by Hilton")
B<-c("Andaz", "Grand Hyatt", "Park Hyatt", "The Unbound Collection by Hyatt", "Hyatt Centric", "Hyatt Regency", "JdV by Hyatt", "Hyatt House", "Hyatt Place","NA","NA","NA","NA","NA")
C<-c("JW Marriott", "The Ritz-Carlton", "W Hotels", "Marriott Hotels", "Sheraton", "Westin", "Courtyard", "Residence Inn", "Fairfield by Marriott","NA","NA","NA","NA","NA")

names_list <- list('Hilton' = names_hilton, 'Hyatt' = names_hyatt, 'Marriott' = names_marriott)

# 2. Dataframes - relevant data sourced from Q4 2023 Earnings Reports (Hilton Worldwide Holdings, Hyatt Hotels, Marriott International)

adr_hilton<-c(515.05,539.47,312.61,220.43,187.14,232.65,139.91,178.06,175.16,143.17,126.36,122.66,153.26,135.94)
revpar_hilton<-c(334.05,266.21,237.23,156.35,128.33,161.05,93.34,117.79,121.75,96.69,86.68,81.39,115.12,100.61)
occupancy_hilton<-c(64.9,49.3,75.9,70.9,68.6,69.2,66.7,66.1,69.5,67.5,68.6,66.4,75.1,74.0)
rooms_hilton<-c(9840,1774,16950,6940,226015,31000,154708,14719,61844,149130,327690,24755,61624,75069)

adr_hyatt<-c(348.21,242.29,442.06,255.00,225.96,194.18,214.87,161.45,145.15,NA,NA,NA,NA,NA)
revpar_hyatt<-c(248.57,169.52,304.03,152.55,169.01,126.24,140.94,114.06,98.59,NA,NA,NA,NA,NA)
occupancy_hyatt<-c(71.4,70.0,68.8,59.8,74.8,65.0,65.6,70.6,67.9,NA,NA,NA,NA,NA)
rooms_hyatt<-c(7132,32506,8372,8295,11888,98544,9517,19154,62848,NA,NA,NA,NA,NA)

adr_marriott<-c(307.46,494.40,331.27,205.71,182.40,227.72,157.81,165.14,129.24,NA,NA,NA,NA,NA)
revpar_marriott<-c(209.27,317.65,214.88,130.26,111.56,150.71,102.04,119.27,83.72,NA,NA,NA,NA,NA)
occupancy_marriott<-c(68.1,64.2,64.9,63.3,61.2,66.2,64.7,72.2,64.8,NA,NA,NA,NA,NA)
rooms_marriott<-c(39129,30200,18454,114192,83646,46701,52769,12973,11289,NA,NA,NA,NA,NA)

data<-data.frame(revpar_hilton,adr_hilton,occupancy_hilton,rooms_hilton,revpar_hyatt,adr_hyatt,occupancy_hyatt,rooms_hyatt,revpar_marriott,adr_marriott,occupancy_marriott,rooms_marriott)

# 3. UI

ui <- fluidPage(
  h1('Hotel Metrics: Q4 2023'),
  h4('The purpose of this visualisation is to allow users to analyse key hotel KPIs across major hotel brands. Data sourced from relevant quarterly earnings reports.'),
  h5('ADR = Average Daily Rate, RevPAR = Revenue per available room.'),
  h5(''),
  a("Hilton Worldwide Holdings Q4 2023 earnings data", href="https://ir.hilton.com/~/media/Files/H/Hilton-Worldwide-IR-V3/quarterly-results/2024/q4-2023-earnings-release.pdf"),
  h5(''),  
  a("Hyatt Hotels Q4 2023 earnings data", href="https://investors.hyatt.com/files/doc_financials/2023/q4/Final-Q4-2023-Earnings-Release-Full.pdf"),
  h5(''),  
  a("Marriott International Q4 2023 earnings data", href="https://marriott.gcs-web.com/static-files/fab13bad-9342-4162-b392-d5a1cba1403f"),
  h5(''),
  sidebarPanel(
    selectInput("value",
                "Name of hotel",
                values1,
                selected = 'Hilton', multiple = F),
    selectInput("brand", "Legend (indicating brand - must match with name of hotel)", choices = c('Hilton'='A', 'Hyatt'='B', 'Marriott'='C'), selected = 'A'),
    selectInput("xcol", "X Variable", names_list['Hilton'], multiple = F),
    selectInput("ycol", "Y Variable", names_list['Hilton'], multiple = F),
    selectInput("sizecol", "Bubble Size", names_list['Hilton'], multiple = F),
    selected = names(data)[[2]]),
  mainPanel(
    plotlyOutput('plot')
  )
)

# 4. Server with updateSelectInput functions and plotly visualisation

server <- function(input, output, session) {
      
  observe({              
    updateSelectInput(session, 
                      'xcol',
                      choices = names_list[input$value],
                      selected = names_list[input$value][1])
  })
  
  observe({              
    updateSelectInput(session, 
                      'ycol',
                      choices = names_list[input$value],
                      selected = names_list[input$value][1])
  })
  
  observe({              
    updateSelectInput(session, 
                      'sizecol',
                      choices = names_list[input$value],
                      selected = names_list[input$value][1])
  })

  brand <- reactive({
    x <- get(input$brand)
  })
      
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
    color = ~brand(),
    colors = 'Paired',
    marker = list(opacity = 0.5, sizemode = 'diameter')))
}

shinyApp(ui,server)

# References

# Hilton Worldwide Holdings - Q4 2023 Results: https://ir.hilton.com/~/media/Files/H/Hilton-Worldwide-IR-V3/quarterly-results/2024/q4-2023-earnings-release.pdf
# Hyatt Hotels - Q4 2023 Results: https://investors.hyatt.com/files/doc_financials/2023/q4/Final-Q4-2023-Earnings-Release-Full.pdf
# Incorporate a Plotly graph into a Shiny App: https://community.plotly.com/t/incorporate-a-plotly-graph-into-a-shiny-app/5329/2
# Marriott International - Q4 2023 Results: https://marriott.gcs-web.com/static-files/fab13bad-9342-4162-b392-d5a1cba1403f
# Stack Overflow - Select dataframe in Shiny: https://stackoverflow.com/questions/34148322/select-dataframe-in-shiny