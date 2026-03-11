############################################################
# Data Manipulation and Visualization in R
# Author: Nicolas Cardenas
# This script accompanies the RMarkdown tutorial
# Students can run this code step by step in RStudio
############################################################


############################################################
# 1. INSTALL PACKAGES (RUN ONLY ONE TIME)
############################################################

# Packages are collections of functions written by other R users.
# Installing a package downloads it to your computer.
# You only need to install a package once.

#install.packages("tidyverse")   # Collection of packages for data science
install.packages("pokemon")     # Dataset containing Pokemon statistics
install.packages("writexl")     # Package used to save Excel files


############################################################
# 2. LOAD PACKAGES (RUN EVERY TIME YOU START R)
############################################################

# After installing a package, you must load it every session
# using the library() function.

library(tidyverse)   # Loads ggplot2, dplyr, and other useful tools
library(pokemon)     # Loads the Pokemon dataset
library(writexl)     # Allows exporting Excel files


############################################################
# 3. LOAD THE DATASET
############################################################

# The pokemon package contains a dataset called "pokemon".
# We store it in a new object called "pokemondata".

pokemondata <- pokemon

# In R, "<-" means "assign the value on the right to the name on the left"


############################################################
# 4. EXPLORE THE DATA
############################################################

# glimpse() gives a quick overview of the dataset:
# - variable names
# - variable types
# - first few values

glimpse(pokemondata)


# View() opens the dataset in a spreadsheet-like viewer
# (similar to Excel)
View(pokemondata)

# Count number of rows (observations)
nrow(pokemondata)

# Count number of columns (variables)
ncol(pokemondata)

# List all column names
names(pokemondata)

# summary() shows basic statistics for each variable
summary(pokemondata)


############################################################
# 5. SELECT SPECIFIC COLUMNS
############################################################

# select() keeps only the columns we want

poke_select <- pokemondata %>%
  select(pokemon, type_1, hp, attack, defense)

# %>% is called the "pipe"
# It means: "take the object on the left and apply the function on the right"

# Look at the first rows of the new dataset
head(poke_select)


# Remove columns we do not need
pokemondata <- pokemondata %>%
  select(-id, -url_image, -url_icon)

# The minus sign (-) means "remove these columns"


############################################################
# 6. FILTER ROWS
############################################################

# filter() keeps only rows that satisfy a condition

# Example: Pokemon with base experience greater than 200
high_exp_pokemon <- pokemondata %>%
  filter(base_experience > 200)


# Example: keep only Fire type Pokemon
fire_pokemon <- pokemondata %>%
  filter(type_1 == "fire")

# == means "is equal to"


# Keep Fire OR Water types
fire_or_water <- pokemondata %>%
  filter(type_1 == "fire" | type_1 == "water")

# | means OR


# Keep Fire type AND attack greater than 80
strong_fire <- pokemondata %>%
  filter(type_1 == "fire" & attack > 80)

# & means AND


# Count how many rows satisfy the condition
nrow(high_exp_pokemon)


############################################################
# 7. CREATE NEW VARIABLES
############################################################

# mutate() creates new columns or modifies existing ones

# Convert weight from hectograms to kilograms
pokemondata <- pokemondata %>%
  mutate(weight_kg = weight / 10)

# Now the dataset has a new column called weight_kg


# Create a category based on weight
pokemondata <- pokemondata %>%
  mutate(size_category = ifelse(weight_kg > 50, "heavy", "light"))

# ifelse() works like this:
# ifelse(condition, value_if_true, value_if_false)


# Example of replacing values in a column
modified_data <- pokemondata %>%
  mutate(type_1_new = replace(type_1, type_1 == "fire", "flame"))

# This creates a new column where "fire" becomes "flame"


# Check the result
pokemondata %>%
  select(pokemon, weight, weight_kg, size_category) %>%
  head()


############################################################
# 8. GROUP AND SUMMARIZE DATA
############################################################

# group_by() splits the data into groups
# summarize() calculates statistics for each group

summary_pokemon <- pokemondata %>%
  group_by(type_1) %>%
  summarize(
    count = n(),                                  # number of Pokemon
    avg_base_exp = mean(base_experience, na.rm = TRUE),  # average experience
    max_height = max(height, na.rm = TRUE),       # tallest Pokemon
    total_weight = sum(weight_kg, na.rm = TRUE),  # total weight
    avg_attack = mean(attack, na.rm = TRUE)       # average attack
  )

# Show the summarized table
summary_pokemon


############################################################
# 9. SORT DATA
############################################################

# arrange() sorts the dataset

# desc() means descending order (largest to smallest)

sorted_by_exp <- pokemondata %>%
  arrange(desc(base_experience))


# Show the top 10 rows
head(sorted_by_exp %>%
       select(pokemon, type_1, base_experience), 10)


############################################################
# 10. COMPLETE DATA PIPELINE EXAMPLE
############################################################

# This example chains multiple steps together

result <- pokemondata %>%
  filter(!is.na(base_experience)) %>%   # remove missing values
  mutate(weight_kg = weight / 10) %>%   # create weight in kg
  group_by(type_1) %>%                  # group by Pokemon type
  summarize(
    count = n(),
    avg_attack = mean(attack, na.rm = TRUE),
    avg_weight = mean(weight_kg, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_attack))             # sort by highest attack

# Display results
result


############################################################
# 11. SCATTER PLOT
############################################################

# ggplot2 creates plots layer by layer

ggplot(pokemondata, aes(x = weight, y = height, color = type_1)) +
  geom_point(size = 3, alpha = 0.7) +    # each observation becomes a point
  labs(
    title = "Pokemon Height vs Weight",
    x = "Weight (hg)",
    y = "Height (dm)",
    color = "Primary Type"
  ) +
  theme_minimal()

# aes() defines what variables appear on axes or colors


############################################################
# 12. BAR PLOT
############################################################

# This plot uses the summarized dataset

ggplot(summary_pokemon,
       aes(x = reorder(type_1, avg_base_exp),
           y = avg_base_exp,
           fill = type_1)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  coord_flip() +    # rotates the plot horizontally
  labs(
    title = "Average Base Experience by Pokemon Type",
    x = "Pokemon Type",
    y = "Average Base Experience"
  ) +
  theme_minimal()


############################################################
# 13. HISTOGRAM
############################################################

# Histogram shows the distribution of a numeric variable

ggplot(pokemondata, aes(x = base_experience)) +
  geom_histogram(
    binwidth = 20,      # width of each bar
    fill = "steelblue",
    color = "black",
    alpha = 0.7
  ) +
  labs(
    title = "Distribution of Pokemon Base Experience",
    x = "Base Experience",
    y = "Number of Pokemon"
  ) +
  theme_minimal()


############################################################
# 14. BOXPLOT
############################################################

# Boxplots show distribution across groups

ggplot(pokemondata,
       aes(x = reorder(type_1, base_experience, median),
           y = base_experience,
           fill = type_1)) +
  geom_boxplot(
    outlier.shape = 21,
    outlier.fill = "red",
    outlier.size = 2,
    alpha = 0.7
  ) +
  coord_flip() +
  labs(
    title = "Base Experience Distribution by Pokemon Type",
    x = "Pokemon Type",
    y = "Base Experience"
  ) +
  theme_minimal() +
  theme(legend.position = "none")


############################################################
# 15. SAVE DATA
############################################################

# Save dataset as CSV file
write_csv(pokemondata, "pokemon_data.csv")

# Save dataset as Excel file
write_xlsx(pokemondata, "pokemon_data.xlsx")


############################################################
# 16. SAVE PLOTS
############################################################

# Save the last plot displayed
ggsave("my_plot.png", dpi = 300, width = 8, height = 6)

# Save a specific plot object

my_plot <- ggplot(pokemondata, aes(x = weight, y = height)) +
  geom_point()

ggsave("weight_vs_height.png",
       plot = my_plot,
       dpi = 300,
       width = 8,
       height = 6)


############################################################
# 17. EXERCISE EXAMPLE
############################################################

# Example analysis: Pokemon Gengar can defeat


# Count how many Pokemon satisfy this condition

# Count how many per Pokemon type


