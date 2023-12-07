[Home](https://mgcodesandstats.github.io/) |
[Portfolio](https://mgcodesandstats.github.io/articles) |
[GitHub](https://github.com/mgcodesandstats) |
[LinkedIn](https://www.linkedin.com/in/michaeljgrogan/) |
[Medium](https://mgcodesandstats.medium.com/) |
[Stack Overflow](https://stats.stackexchange.com/users/137066/michael-grogan) |
[Terms](https://mgcodesandstats.github.io/terms/) |
[E-mail](mailto:contact@michael-grogan.com)

# Creating an interactive bubble chart with Shiny and pyplot

Shiny is a highly flexible tool for creating custom visualisations. The ability to create interactive charts can allow an end-user to visualise and gain a more intuitive understanding of data as compared to the use of a static chart.

In this example, we will see how to create an bubble chart using Shiny and pyplot to visualise sales data.

## Sales Data

Let us consider the following hypothetical dataset.

```
> data<-data.frame(product, price, quantity, sales, period)
> data

     product price quantity sales period
1  Product A    82      497 40754   1 Q1
2  Product A    87      692 60204   1 Q2
3  Product A    55      683 37565   1 Q3
4  Product A    60      691 41460   1 Q4
5  Product A    70      727 50890   2 Q1
6  Product A    89      655 58295   2 Q2
7  Product A    39      782 30498   2 Q3
8  Product A    51      655 33405   2 Q4
9  Product A    35      718 25130   3 Q1
10 Product A    85      674 57290   3 Q2
11 Product B   132      633 83556   1 Q1
12 Product B    94      627 58938   1 Q2
13 Product B    71      497 35287   1 Q3
14 Product B    56      780 43680   1 Q4
15 Product B    76      423 32148   2 Q1
16 Product B   106      587 62222   2 Q2
17 Product B    63      602 37926   2 Q3
18 Product B   130      754 98020   2 Q4
19 Product B    52      502 26104   3 Q1
20 Product B   145      661 95845   3 Q2
```

The above is a hypothetical dataset of two products (A and B), with the associated price, quantity and number of sales by quarter (with 1, 2, 3 preceding the quarter representing years 1, 2, and 3).

We would like to create a Shiny Web App that can display these variables - with two variables plotted across an x and y axis and the bubble size representing the third variable.

## Creating UI and Server Files

The shiny and plotly libraries are loaded in R, and three drop-down menus are created - whereby we can select which variables to display on the x and y axes, as well as which variable to display by bubble size. Please feel free to also refer to this useful [example](https://community.plotly.com/t/incorporate-a-plotly-graph-into-a-shiny-app/5329/2).

```
library(shiny)
library(plotly)

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
```

After creating the UI, the reactive variables can be defined, i.e. that which to display on the x and y axes and bubble size, as well as distinguishing product by color.

```
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
      color = ~product,
      colors = 'Paired',
      marker = list(opacity = 0.5, sizemode = 'diameter'))
  )
  
}

shinyApp(ui,server)
```

The full code script is available [here](https://github.com/MGCodesandStats/shiny-web-apps/blob/master/sales/sample_sales.R).

By clicking **Run app**, we can now interact with the visualisation that we have just built. Here is a visualisation with period on the x-axis, price on the y-axis and sales represented by bubble size.

[![shiny-sales-metrics-1](shiny-sales-metrics-1.png)](https://michael-grogan.shinyapps.io/sales/)

Source: Visualisation created by author using Shiny

## Publishing a Shiny Web App

Now that we have run the app successfully - we are ready to publish it!

To do this, you must first create a Shiny account at [shinyapps.io](https://www.shinyapps.io/).

Once an account has been created - the app can then be published to that account through R by selecting **Publish Application**:

![publish_application](publish_application.png)

Source: R Output

Now, the name of the app is designated and we can see that the R file is being published to the relevant account:

![publish_to_server](publish_to_server.png)

Source: R Output

The app has now been published and is available here: **[Shiny Web App: Sales Metrics](https://michael-grogan.shinyapps.io/sales/)**.

## Conclusion

In this example, you have seen:

- How to create a bubble chart using pyplot
- Design an interactive Shiny Web App through customising UI and server code
- Publish a Shiny Web Applications using shinyapps.io

You can also find more examples of visualisations developed with Shiny [here](https://github.com/MGCodesandStats/shiny-web-apps).

## References

- [Code Script](https://github.com/MGCodesandStats/shiny-web-apps/blob/master/sales/sample_sales.R)
- [GitHub: Shiny Web Apps repository](https://github.com/MGCodesandStats/shiny-web-apps)
- [plotly: Incorporate a Plotly graph into a Shiny App](https://community.plotly.com/t/incorporate-a-plotly-graph-into-a-shiny-app/5329/2)
- [Sales Metrics:Shiny Web App](https://michael-grogan.shinyapps.io/sales/)
- [shinyapps.io](https://www.shinyapps.io/)
