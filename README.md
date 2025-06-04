This mini project is meant to help me understand and showcase my knpowledge of R Studio and sports data.

Follow my daily updates on the project on my LinkedIn page:  
https://www.linkedin.com/in/juliantcoleman/

# Bengals Snap Analysis 2024

This project is an R-based analysis of the Cincinnati Bengals' 2024 NFL snap counts using data from [`nflreadr`](https://www.nflverse.com/) and `nflfastR`.

## What I'm Doing

I am pulling and summarizing offensive and defensive snap count data for Bengals players in the 2024 NFL season. My goal is to:

- Practice data manipulation using the `tidyverse` suite in R
- Understand player usage on offense and defense
- Identify high-usage players (those playing ≥ 70% of snaps)


## What I'm Learning

This project helps me build skills in:

- Working with real sports data using `nflreadr`
- Data wrangling with `dplyr` (`group_by()`, `summarise()`, `mutate()`, etc.)
- Formatting with `scales::percent()`
- Joining and filtering datasets
- Git and GitHub for version control

## File Structure

- `bengals_snaps.R`: Main R script for loading, cleaning, and analyzing the data
- `README.md`: This file

## Packages Used

```r
tidyverse
nflfastR
nflreadr
splines
scales
