# Install necessary packages 
install.packages(c("nflreadr", "nflfastR", "splines", "tidyverse"))

# Load proper libraries
library(nflreadr)
library(nflfastR)
library(tidyverse)
library(scales)

# Load and filter snap counts for Bengals 2024 season
bengals_snaps_2024 <- load_snap_counts() %>%
  filter(team == "CIN", season == 2024)

# Summarize offensive snap counts
bengals_off_snaps_2024 <- bengals_snaps_2024 %>%
  filter(offense_snaps > 0) %>%
  group_by(player, position) %>%
  summarise(
    total_off_snaps = sum(offense_snaps, na.rm = TRUE),
    pct_off_snaps = mean(offense_pct, na.rm = TRUE),
    .groups = "drop"
  )

# Summarize defensive snap counts
bengals_def_snaps_2024 <- bengals_snaps_2024 %>%
  filter(defense_snaps > 0) %>%
  group_by(player, position) %>%
  summarise(
    total_def_snaps = sum(defense_snaps, na.rm = TRUE),
    pct_def_snaps = mean(defense_pct, na.rm = TRUE),
    .groups = "drop"
  )

# Merge offensive and defensive snap summaries
all_bengals_snaps_2024 <- full_join(
  bengals_off_snaps_2024,
  bengals_def_snaps_2024,
  by = c("player", "position")
)

# Add high usage label and format percentages
snaps_2024 <- all_bengals_snaps_2024 %>%
  mutate(
    high_usage = if_else(
      pct_off_snaps >= 0.70 | pct_def_snaps >= 0.70,
      "Yes", "No", missing = "No"
    ),
    offense_pct = percent(pct_off_snaps * 1, accuracy = 0.1),
    defense_pct = percent(pct_def_snaps * 1, accuracy = 0.1)
  ) 




library(ggplot2)
install.packages("plotly")
library(plotly)



# Create the ggplot
p <- ggplot(snaps_2024, aes(x = reorder(position, -total_off_snaps))) +
  geom_point(
    aes(
      y = pct_off_snaps,
      text = paste0(
        "Player: ", player, "\n",
        "Position: ", position, "\n",
        "High Usage: ", high_usage, "\n",
        "Total Snaps: ", total_off_snaps, "\n",
        "Offense %: ", round(pct_off_snaps * 100, 1), "%\n"
      )
    ),
    color = "orange", alpha = 0.7, size = 3
  ) +
  geom_point(
    aes(
      y = pct_def_snaps,
      text = paste0(
        "Player: ", player, "\n",
        "Position: ", position, "\n",
        "High Usage: ", high_usage, "\n",
        "Total Snaps: ", total_def_snaps, "\n",
        "Defense %: ", round(pct_def_snaps * 100, 1), "%\n"
      )
    ),
    color = "black", alpha = 0.7, size = 3
  ) +
  labs(
    title = "Bengals 2024 Snap % (Offense & Defense)",
    x = "Position",
    y = "Snap %"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Convert to interactive plot
ggplotly(p, tooltip = "text")
# 

