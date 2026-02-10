# ═══════════════════════════════════════════════════════════
# PROJECT 2: IMDB MOVIE ANALYSIS
# Started: [03/02/2026]
# 
# Purpose: Analyze 1000 top-rated IMDB movies
# Dataset: imdb_top_1000.csv from Kaggle
# Questions: 6 business questions about movies, genres, ratings
# ═══════════════════════════════════════════════════════════

#Start fresh
rm(list=ls())
# Load libraries
library(tidyverse)
library(sqldf)


# Load the data
movies <- read.csv("imdb_top_1000.csv")

# What columns do we have?
colnames(movies)

# How many movies?
nrow(movies)

# Look at first few rows
head(movies)

# See what genres look like
head(movies$Genre)

# ═══════════════════════════════════════════════════════════
# QUESTION 1: How many movies in each genre?----------
# ═══════════════════════════════════════════════════════════

q1_genre_counts <- sqldf("
  SELECT Genre, COUNT(*) AS movie_count
  FROM movies
  GROUP BY Genre
  ORDER BY movie_count DESC
")

# View results
head(q1_genre_counts, 10)  # Top 10 genre combinations

#QUESTION 2:
#"Which genres have the highest average ratings?"

q2_genre_ratings<-sqldf("SELECT Genre, AVG(IMDB_Rating) AS avg_rating
FROM movies
GROUP BY Genre
ORDER BY avg_rating DESC")


#View top 10
head(q2_genre_ratings, 10)

#QUESTION 3:
#"What are the top 10 highest-rated movies?"
q3_top_movies<-sqldf("SELECT Series_Title, IMDB_Rating FROM movies
ORDER BY IMDB_Rating DESC
LIMIT 10")

#QUESTION 4:
#"Which years had the most highly-rated movies (average rating > 7)?"
q4_higly_rated_years<-sqldf("SELECT Released_Year, COUNT(*) as movie_count,
AVG(IMDB_Rating) AS avg_rating
      FROM movies 
      GROUP BY Released_Year
      HAVING avg_rating>7
      ORDER BY avg_rating DESC")

head(q4_higly_rated_years, 10)

#QUESTION 5:
#"Which directors have the most highly-rated films (minimum 3 films)?"
q5_top_directors<-sqldf("SELECT Director, COUNT(*) as films_released,
      AVG(IMDB_Rating) AS avg_rating
      FROM movies
      GROUP BY Director
      HAVING COUNT(*)>=3
      ORDER BY avg_rating DESC")
head(q5_top_directors, 10)

#QUESTION 6:
#"How have average movie ratings changed over decades?"

# Convert Released_Year from text to number
movies$Released_Year <- as.numeric(movies$Released_Year)

q6_decade_trends <- sqldf("
  SELECT (Released_Year/10)*10 AS decade,
         COUNT(*) AS movie_count,
         AVG(IMDB_Rating) AS avg_rating
  FROM movies
  WHERE Released_Year > 1900
  GROUP BY (Released_Year/10)*10
  ORDER BY decade
")

# ═══════════════════════════════════════════════════════════
# VISUALIZATION 1: Top 10 Genres by Average Rating
# ═══════════════════════════════════════════════════════════

# Get top 10 genres
top_genres <- head(q2_genre_ratings, 10)

# Create bar chart
ggplot(top_genres, aes(x = reorder(Genre, avg_rating), y = avg_rating)) +
  geom_col(fill = "steelblue") +
  coord_flip() +  # Makes bars horizontal (easier to read genre names)
  labs(
    title = "Top 10 Movie Genres by Average IMDB Rating",
    x = "Genre",
    y = "Average Rating"
  ) +
  theme_minimal()

# ═══════════════════════════════════════════════════════════
# VISUALIZATION 2: Top 10 Directors by Average Rating
# ═══════════════════════════════════════════════════════════

# Get top 10 directors
top_directors <- head(q5_top_directors, 10)

# Create bar chart
ggplot(top_directors, aes(x = reorder(Director, avg_rating), y = avg_rating)) +
  geom_col(fill = "darkgreen") +
  coord_flip() +
  labs(
    title = "Top 10 Directors by Average IMDB Rating",
    subtitle = "(Minimum 3 films)",
    x = "Director",
    y = "Average Rating"
  ) +
  theme_minimal()

# ═══════════════════════════════════════════════════════════
# VISUALIZATION 3: Rating Trends Over Decades
# ═══════════════════════════════════════════════════════════

# ═══════════════════════════════════════════════════════════
# VISUALIZATION 3: Rating Trends Over Decades
# ═══════════════════════════════════════════════════════════

# Create line chart
ggplot(q6_decade_trends, aes(x = decade, y = avg_rating)) +
  geom_line(color = "darkred", linewidth = 1.2) + 
  geom_point(color = "darkred", size = 3) +
  labs(
    title = "Average Movie Ratings by Decade",
    x = "Decade",
    y = "Average IMDB Rating"
  ) +
  theme_minimal() +
  ylim(7.5, 8.5)

# ═══════════════════════════════════════════════════════════
# KEY FINDINGS
# ═══════════════════════════════════════════════════════════

cat("
═══════════════════════════════════════════════════════════
KEY FINDINGS: IMDB Top 1000 Movies Analysis
═══════════════════════════════════════════════════════════

FINDING 1: Genre Quality is Consistently High

The highest-rated genre combination is 'Animation, Drama, War' with an 
average rating of 8.50. However, variation among top-rated genres is 
minimal (most range between 8.3-8.5). This suggests that among elite 
movies, genre matters less than execution quality—any genre can produce 
exceptional films when done well.

FINDING 2: Christopher Nolan Leads Elite Directors

Christopher Nolan has the highest average rating (8.46) among directors 
with at least 3 films in the top 1000. Other notable directors include 
Peter Jackson, Francis Ford Coppola, and Stanley Kubrick. While Nolan 
leads, the differences between top directors are small, indicating that 
all elite directors consistently produce highly-rated work.

FINDING 3: Recent Decades Show Lower Average Ratings

Older movies (1920s-1950s) have higher average ratings (~8.1-8.2) compared 
to recent decades (2000s-2010s: ~7.9). This likely reflects 'survivor bias'—
only the best older films remain well-known and highly rated, while recent 
decades include a broader range of quality as more films are produced and 
rated. The smaller variation in recent years suggests more diverse film 
production.

RECOMMENDATION:

For filmmakers: Focus on quality execution rather than choosing the 'right' 
genre. For audiences: Explore classic films from earlier decades for 
consistently high-quality cinema, but don't overlook recent films—the lower 
average is due to volume, not a decline in filmmaking quality.

═══════════════════════════════════════════════════════════
")         
