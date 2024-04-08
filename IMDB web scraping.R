# load required libraries
# if you haven't already, install via bottom right window: Packages
library(rvest)
library(tidyverse)

# IMDB

# specifying the url for desired website to be scraped
# Chernobyl reviews
url <- 'https://www.imdb.com/title/tt7366338/reviews?sort=curated&dir=desc&ratingFilter=2'

# Document load: reading the HTML code from the website
doc <- read_html(url)

# Parsing and Extraction:
# Review Title
doc %>% 
  html_nodes(".title") %>%
  html_text() -> review_title
# alternative way to select the title: movie_title <- html_text(html_nodes(doc,'.lister-item-header a'))
# Movie Reviews
doc %>% 
  html_nodes(".text") %>%
  html_text() -> review_content

# Numeric rating
doc %>%
  html_nodes(".ipl-ratings-bar") %>%
  html_text() -> movie_rating

# Transformation
# Save in a data frame
dat2 <- data.frame(review_title,
                  review_content, 
                  movie_rating)

#check the number of element
length(review_title)
length(review_content)
length(movie_rating)

library(rvest)
library(tidyverse)

# Initialize lists to store data from each page
all_review_titles <- list()
all_review_contents <- list()
all_movie_ratings <- list()

# Loop through each star rating from 1 to 10
for (i in 1:10) {
  # Modify the URL for each star rating
  url <- paste0('https://www.imdb.com/title/tt7366338/reviews?sort=curated&dir=desc&ratingFilter=', i)
  
  # Read the HTML code from the website
  doc <- read_html(url)
  
  # Extract review titles, contents, and ratings
  review_titles <- doc %>% html_nodes(".title") %>% html_text()
  review_contents <- doc %>% html_nodes(".text") %>% html_text()
  movie_ratings <- rep(i, length(review_titles))
  
  # Store the data for this page
  all_review_titles[[i]] <- review_titles
  all_review_contents[[i]] <- review_contents
  all_movie_ratings[[i]] <- movie_ratings
  
  # Pause for 1 second before the next iteration
  Sys.sleep(1)
}

# Combine the data from all pages
dat2 <- data.frame(
  review_title = unlist(all_review_titles),
  review_content = unlist(all_review_contents),
  movie_rating = unlist(all_movie_ratings)
)

# Remove new line characters from the 'review_title' and 'review_content' columns
dat2$review_title <- gsub("\n", " ", dat2$review_title)
dat2$review_content <- gsub("\n", " ", dat2$review_content)

# Write the cleaned data frame to a TXT file with tab as the separator
write.table(dat2, file = "Chernobyl.txt", sep = "\t", row.names = FALSE, quote = FALSE)
