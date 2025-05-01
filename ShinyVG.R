library(shiny)
library(ggplot2)

# load in the data that will be used

games_df <- fetch_game_data_env(pages = 2)

# Create the user interface for the viewer
ui <- fluidPage(
  titlePanel("Game Metric Histogram"),
  sidebarLayout(
    sidebarPanel(
      selectInput("metric", "Choose metric to plot:",
                  choices = names(games_df)[sapply(games_df, is.numeric)],
                  selected = "rating"),
      sliderInput("bins", "Number of bins:", min = 5, max = 50, value = 20)
    ),
    mainPanel(
      plotOutput("histPlot")
    )
  )
)

# Define the server logic that is ran behind the shiny app.
server <- function(input, output) {
  output$histPlot <- renderPlot({
    ggplot(games_df, aes_string(x = input$metric)) +
      geom_histogram(bins = input$bins, fill = "lightblue", color = "black") +
      labs(
        title = paste("Histogram of", input$metric),
        x = input$metric,
        y = "Count"
      ) +
      theme_minimal()
  })
}

# Run the app
# Use runApp("ShinyVG.R")
shinyApp(ui = ui, server = server)
