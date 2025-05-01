library(httr)
library(jsonlite)
library(dplyr)

# Use this function to store API key once per session
set_rawg_key <- function(key) {
  Sys.setenv(RAWG_API_KEY = key)
}

# Main function to fetch game data (requires an API key)
fetch_game_data <- function(api_key = Sys.getenv("RAWG_API_KEY"), pages = 1, enrich = FALSE) {
  if (api_key == "") stop("API key not set. Use set_rawg_key().")

  all_games <- list()
  for (page in 1:pages) {
    url <- paste0("https://api.rawg.io/api/games?key=", api_key, "&page=", page, "&page_size=40")
    response <- GET(url)
    if (response$status_code != 200) stop("Failed to fetch data.")

    data <- fromJSON(content(response, "text"))
    all_games[[page]] <- data$results
    Sys.sleep(1)
  }

  bind_rows(all_games) %>%
    select(name, released, rating, ratings_count, metacritic, playtime, genres) %>%
    filter(!is.na(rating))
}

# Wrapper to fetch using stored key
fetch_game_data_env <- function(pages = 1, enrich = FALSE) {
  fetch_game_data(pages = pages, enrich = enrich)
}

#  Create a function where the user may search for a video game through a variety
#  of ways. EX.  games <- get_games(search  = "call of duty")

get_games <- function(search = NULL, genres = NULL, platforms = NULL,
                      dates = NULL, ordering = NULL, page_size = 20) {
  parameters <- list(
    search = search,
    genres = genres,
    platforms = platforms,
    dates = dates,
    ordering = ordering,
    page_size = page_size
  )
  rawg_request("/games", parameters)$results
}


#  Allow user to gather details of the game

#  EX. outlast <- get_game_details(3790)
#      outlast$genre


get_game_details <- function(game_id) {
  rawg_request(paste0("/games/", game_id))
}



# Allow user to categorize the genres of the file

get_genres <- function() {
  rawg_request("/genres")$results
}



# Summarize data frame using:
# summarize_game_data(games_df)

summarize_game_data <- function(games_df) {
  games_df %>%
    summarise(
      avg_rating = mean(rating, na.rm = TRUE),
      num_games = n(),
      earliest = min(released, na.rm = TRUE),
      latest = max(released, na.rm = TRUE)
    )
}
