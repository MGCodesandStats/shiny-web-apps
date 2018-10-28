#Libraries
library(shiny)
library(ggplot2)
library(scales)
require(Quandl)
library("TTR")

#Shiny Application
shinyServer(function(input,output) {
  
  output$FXResults <- renderPlot ({
    
    currency = Quandl(input$symbols,start_date=input$start_date,end_date=input$end_date,type="xts")
    currencydf=data.frame(currency)
    simplemovingaverage=SMA(currencydf$currency,n=20)
    plot(currencydf$currency,type='l',col="blue",xlab="Days",ylab="Rate")
    lines(simplemovingaverage,type='l',col='red')
    title(main=input$symbols)
  })
})