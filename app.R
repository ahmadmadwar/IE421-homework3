
library(shiny)
library(ggplot2)
library(datasets)
mtcars1 <- mtcars
mtcars1$am <- factor(mtcars1$am, labels = c("Automatic", "Manual"))
ui <- fluidPage(
  titlePanel("Miles Per Gallon"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear"))
    ),
    mainPanel(
      plotOutput("mpgPlot")
      
    )
  )
)
server <- function(input, output) {
  output$mpgPlot <- renderPlot({
    ggplot(data=mtcars1, aes(x=mpg)) + 
      geom_histogram(binwidth=5,col="white", 
                     fill="steelblue", alpha =0.5) + 
      labs(title=paste("mpg ~", input$variable)) +
      labs(x="mpg", y="Count") + 
      facet_wrap(~mtcars1[[input$variable]], nrow = 3)
  })
}
shinyApp(ui, server)