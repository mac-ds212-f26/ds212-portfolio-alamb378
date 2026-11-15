#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("city",
                        "Select a city:",
                        choices = metro_names <- data_by_dist |>
                          pull(metro_name) |>
                          unique()),
            sliderInput("slider",
                        "Span Parameter:",
                        min = 0,
                        max = 1,
                        value = 0.5)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("scatterPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$scatterPlot <- renderPlot({
        data_by_dist |>
        filter(metro_name == input$city) |>
        ggplot(aes(x=entropy, y=distmiles))+
        geom_point()+
        geom_smooth(method = "loess", span = input$slider)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
