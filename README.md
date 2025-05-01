Video Games Analytics Package

My final project is an R package designed to analyze video game data using custom functions, the RAWG API, and interactive visualizations using a shiny app.

My package features
* Fetch game data using the RAWG API
* Clean and explore video game datasets
* Launch a Shiny app to explore game trends interactively

Here is how to use it:

***IMPORTANT***
This package uses an API key for RAWG! Luckily, you can get one easily by visiting https://rawg.io/apidocs and signing up. Giving a reason even for a school assignment should give you the key right away!


==== 1. Download the Project ====

Download the zip project.

==== 2. Open project ====

Extract file and open VideoGameAnalytics.Rproj

==== 3. Install devtools ====
Install package "devtools": install.packages("devtools")

==== 4. Install Package ====
Use devtools::install() to downlaod package 

==== 5. Load Package ====
load package using library(VideoGameAnalytics)

==== 6. Load libraries ====
make sure to load all libraries by using devtools::load_all()  (else certain functions won't run due to not finding functions)

==== 7. Set API key ====
Set API key by using set_rawg_key("YOUR_API_KEY_HERE")

==== 8. Load in and Store data frame ====
store data frame and how many rows you want using games_df <- fetch_game_data_env(pages = ###(amount of pages you want (1 page = 40)))

==== 9. Explore Data! ====
Use functions:
  *get_games()
  EX. games <- get_games(search  = "call of duty")
  
  *get_game_details()
  EX. outlast <- get_game_details(3790)
  
  *get_genres()
  
  *summarize_game_data(games_df)

==== 10. Shiny App ====
Run shinyapp histogram: shiny::runApp("ShinyVG.R")
