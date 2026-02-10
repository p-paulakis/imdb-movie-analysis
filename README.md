# IMDB Top 1000 Movies Analysis

## Overview
Analysis of IMDB's top 1000 highest-rated movies to uncover patterns in ratings, genres, directors, and trends over time. This project combines SQL querying with R visualization to extract actionable insights from movie data.

## Dataset
- **Source:** Kaggle - IMDB Top 1000 Movies Dataset
- **Size:** 1,000 movies
- **Variables:** Title, year, genre, rating, director, runtime, and more

## Tools & Technologies
- **R** (tidyverse, sqldf, ggplot2)
- **SQL** for data querying and aggregation
- **Data Visualization** with ggplot2

## Analysis Questions

### 1. Genre Analysis
- How many movies in each genre combination?
- Which genres have the highest average ratings?

### 2. Top Movies
- What are the top 10 highest-rated movies?

### 3. Temporal Trends
- Which years had the most highly-rated movies?
- How have ratings changed across decades?

### 4. Director Analysis
- Which directors have the most highly-rated films (minimum 3 films)?

## Key Findings

### Finding 1: Genre Quality is Consistently High
The highest-rated genre combination is "Animation, Drama, War" (avg 8.50). However, variation among top genres is minimal (8.3-8.5 range), suggesting that execution quality matters more than genre choice for elite films.

### Finding 2: Christopher Nolan Leads Elite Directors
Christopher Nolan has the highest average rating (8.46) among directors with 3+ films. Top directors show small rating differences, indicating consistent excellence across their filmographies.

### Finding 3: Older Movies Show Higher Ratings
Films from 1920s-1950s average 8.1-8.2 ratings, while 2000s-2010s average ~7.9. This likely reflects "survivor bias"—only the best older films remain well-known, while recent decades include broader quality ranges due to higher production volume.

## Visualizations
1. **Top Genres Bar Chart** - Average ratings by genre combination
2. **Top Directors Bar Chart** - Leading directors ranked by average rating
3. **Decade Trends Line Chart** - Rating evolution from 1920s to 2020s

## Files
- `movie_analysis.R` - Complete analysis with SQL queries and visualizations
- `imdb_top_1000.csv` - Source dataset

## Skills Demonstrated
- SQL querying (SELECT, WHERE, GROUP BY, HAVING, aggregations)
- Data manipulation and cleaning in R
- Calculated columns and data transformations
- Data visualization with ggplot2
- Statistical analysis and trend identification
- Business insights and recommendations
- Data quality assessment and cleaning

## How to Run
1. Install required R packages: `tidyverse`, `sqldf`
2. Set working directory to project folder
3. Run `movie_analysis.R`

## Insights for Stakeholders
- **For Filmmakers:** Genre choice matters less than execution quality among successful films
- **For Audiences:** Classic films (pre-1960s) offer consistently high quality; recent films show more variety
- **For Investors:** Elite directors (like Nolan) demonstrate reliable track records of high-rated productions
