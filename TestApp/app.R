#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
rsconnect::setAccountInfo(name='4nc2p2-gabrielle-scibelli',
                          token='156C5C32C4327CFF6340BB5415024A23',
                          secret='Tv+YPOMrFcSH2uhDpGkAW3mihjkCYhHN96PB74OT')

ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(sliderInput("samplesize",
                                 "Sample Size:", min = 100,
                                 max = 10000, value = 1000)),
        mainPanel(plotOutput("distPlot"))
    )
) 

server <- function(input, output) { 
    output$distPlot <- renderPlot({
    hist(rnorm(input$samplesize), 
         col='darkorchid',
         xlab="Sample",
         main="Normally Distributed Sample")}, height=300
    ) 
    }


shinyApp(ui = ui, server = server)


library(rsconnect)
rsconnect::deployApp('https://4nc2p2-gabrielle-scibelli.shinyapps.io/TestApp/')

# Define UI for application that draws a histogram
ui <- fluidPage(sidebarLayout(
    sidebarPanel(
        sliderInput("bins", 
                    "SampleSize")
    )
)

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
