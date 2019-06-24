# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.

library(httpuv)
library(shiny)
library(ggplot2)
library(knitr)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Client Technology Services Processing Cost Estimator"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      helpText("These are the inputs to estimate the total exaption rate:"),
      
      sliderInput(
        "estimateOfRate",
        "Level of Expansion:",
        min = 1,
        max = 12,
        value = 3, 
        step = 0.25), 
      
      sliderInput(
        "docsPerGBEst", 
        "Level of Extraction:", 
        min = 1,
        max = 3,
        value = 0, 
        step = .25),
      
      numericInput(
        "gbPreExp",
        "GB (Pre-Expansion):",
        value = 0, 
        step = 0.1),
      
      helpText("This is for the total cost estimate:"),
      
      sliderInput(
        "costUnit",
        "Cost per Unit ($):",
        min = 0,
        max = 165,
        value = 35,
        step = 5)
      
      
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      helpText("The estimate of expansion rate:"),
      textOutput("estimateOfExpansion"), 
      
      helpText("Based on that estimate, the total cost of processing is:"),
      plotOutput("estimateOfCost")
      
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  theEstimate = reactive({
    
    theEstimate = 0.7707650 + input$estimateOfRate * 0.2966591 + input$docsPerGBEst * 0.0216857
    
    return(theEstimate)
    
  })
  
  
  output$estimateOfExpansion <- renderText({
    
    theEstimate()
    
  })
  
  output$estimateOfCost <- renderPlot({
    
    costEstimate = theEstimate() * input$gbPreExp * input$costUnit
    costLessTen = costEstimate * 0.9
    costPlusTen = costEstimate * 1.1
    
    df = data.frame(
      type = c("10% Discount", "Estimate", "Plus 10%"), 
      cost = c(costLessTen, costEstimate, costPlusTen)
    )
    
    df$cost = round(df$cost, digits = 0)
    
    ggplot(data=df, aes(x=type, y=cost)) +
      geom_bar(stat="identity", fill="steelblue") + 
      geom_text(aes(label=cost), vjust=1.6, color="white", size=3.5)+
      theme_minimal()
    
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

