
# **Tutorial: Data Manipulation and Visualization in R**

::: {style="text-align: center;"}
Nicolas Cardenas

February 20 2025
:::

## **Introduction**

In this tutorial, we will first describe what RStudio is and why we are using it for data analysis. Learning R can take time, and it's normal if some concepts feel unclear at first. Even experienced users frequently look things up! The goal of this tutorial is to reinforce key concepts through repeated practical demonstrations, helping you build confidence and fluency. By the end, you'll be able to manipulate and visualize data effectively, which is crucial in veterinary research and practice.

## What to expect

In this section, we will cover more advanced methods for handling and manipulating data, learn to create plots using `ggplot2`, and discuss the benefits of writing reusable R scripts. These skills are essential for veterinarians who want to analyze and interpret large datasets, such as those related to animal health or behavior.

## **Getting Started**

::: {style="text-align: center;"}
<img src="https://docs.posit.co/ide/user/ide/get-started/images/rstudio-panes-labeled.jpeg" width="717"/>
:::

## RStudio environment

-   **Source**: The script editor where you write and edit R code. It allows for multiple scripts and markdown files to be opened simultaneously.
-   **Environment**: Displays objects, such as data frames and variables, that are currently loaded in your session. It helps track your workspace.
-   **Console**: The interactive area where R commands are executed. You can run code directly here or send it from the Source pane.
-   **Output**: This includes the **Plots**, **Viewer**, and **Help** tabs, where visualizations, web content, and documentation are displayed.

### **Installing and Loading the tidyverse**

``` r
install.packages("tidyverse")  # Install the package (only once)
install.packages("pokemon")    # Install the package (only once)
library(tidyverse)  # Load the package
library(pokemon)
```

### **Importing Data**

::: {style="text-align: center;"}
![](data:image/jpeg;base64,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){width="383"}
:::

We will use a dataset of Pokemon information. The dataset contains 949 rows and 22 columns, including information such as the Pokemon’s name, ID, height, weight, stats, type, and more. A dictionary of variables can be accessed [here](https://cran.r-project.org/web/packages/pokemon/pokemon.pdf).

``` r
# Load pokemon data 
pokemondata = pokemon
# data overview 
glimpse(pokemondata)
View(pokemondata)
```

------------------------------------------------------------------------

## **3. Data Manipulation with dplyr**

### **Selecting and Dropping Columns**

``` r
# Selecting variables (create a new object with the data)
poke_select = pokemondata %>%
  select(pokemon, type_1, hp)
# Eliminate variables (keep the same data object)
pokemondata = pokemondata %>%
  select(-id, -url_image, -url_icon)
```

### **Filtering Rows**

``` r
pokemondata_filtered = pokemondata %>%
  filter(base_experience > 200 )
```

1.  **`filter`**: We filter the dataset to include only rows where `base_experience` is greater than 200

### **Creating New Columns (Mutate)**

``` r
vet_data %>%
  mutate(weight_kg = weight_lbs * 0.453592)
```

### **Creating New Columns (Replace)**

``` r
# Use dplyr to manipulate the data
modified_data <- pokemon_data %>%
  # Replace "fire" with "flame" and create type_1 new column
  mutate(type_1_new = replace(type_1, type_1 == "fire", "flame"))
```

1.  **`mutate`**: We use `mutate` to modify the `type_1` column. The `replace` function is used to change all instances of `"fire"` to `"flame"`.

### **Summarizing Data**

We want to group the Pokemon by their `type_1` and calculate:

1.  The average `base_experience` for each type.

2.  The maximum `height` for each type.

3.  The total `weight` for each type.

``` r
# Group by type_1 and summarize
summary_data <- pokemon %>%
  group_by(type_1) %>%
  summarize(
    avg_base_experience = mean(base_experience, na.rm = TRUE), # Average base experience
    max_height = max(height, na.rm = TRUE),                   # Maximum height
    total_weight = sum(weight, na.rm = TRUE)                  # Total weight
  )
```

**`group_by(type_1)`**: Groups the data by the `type_1` column.

**`summarize`**: Calculates summary statistics for each group:

-   `avg_base_experience`: The average `base_experience` for each type.

-   `max_height`: The maximum `height` for each type.

-   `total_weight`: The total `weight` for each type.

**`na.rm = TRUE`**: Ensures that missing values are ignored in calculations.

### **Sorting Data**

``` r
sorted_by_experience <- pokemon %>%
  arrange(desc(base_experience))
```

------------------------------------------------------------------------

## **4. Data Visualization with ggplot2**

### **Basic Scatter Plot**

``` r
# Create a scatter plot: Weight vs. Height, colored by Type
ggplot(pokemon, aes(x = weight, y = height, color = type_1)) +
  geom_point(size = 3, alpha = 0.7) + # Scatter plot points
  labs(
    title = "Pokemon Height vs. Weight",
    x = "Weight (kg)",
    y = "Height (m)",
    color = "Primary Type"
  )
```

-   `aes(x = weight, y = height, color = type_1)`: Maps weight and height, coloring points by Pokemon type.

-   `geom_point(size = 3, alpha = 0.7)`: Controls point size and transparency.

-   `labs(...)`: Adds titles and axis labels.

### **Bar Plot: Number of Cases per Species**

``` r
# Create a bar plot: Average Base Experience by Type
ggplot(summary_pokemon, 
       aes(x = reorder(type_1, avg_base_experience),
           y = avg_base_experience, fill = type_1)) +
  geom_bar(stat = "identity", show.legend = FALSE) + # Use identity to map values
  coord_flip() + # Flip for better readability
  labs(
    title = "Average Base Experience by Pokemon Type",
    x = "Pokemon Type",
    y = "Average Base Experience"
  ) 
```

-   `reorder(type_1, avg_base_experience)`: Sorts bars by experience.

-   `geom_bar(stat = "identity")`: Uses actual values instead of count.

-   `coord_flip()`: Makes it horizontal for better readability.

### **Histogram of Weights**

``` r
# Create a histogram of base experience
ggplot(pokemon, 
       aes(x = base_experience)) +
  geom_histogram(binwidth = 20, 
                 fill = "steelblue",
                 color = "black",
                 alpha = 0.7) +
  labs(
    title = "Distribution of Pokemon Base Experience",
    x = "Base Experience",
    y = "Count of Pokemon"
  ) 
```

**`aes(x = base_experience)`**: Maps base experience values to the x-axis.

**`geom_histogram(binwidth = 20, fill = "steelblue", color = "black", alpha = 0.7)`**:

-   Uses bins of width 20.

-   Colors bars blue with black edges.

-   `alpha = 0.7` makes bars slightly transparent.

### **Boxplot of Weight by Species**

``` r

# Create a boxplot of base experience by Pokemon type
ggplot(pokemon,
       aes(x = reorder(type_1, base_experience, median),
           y = base_experience, fill = type_1)) +
  geom_boxplot(outlier.shape = 21, 
               outlier.fill = "red",
               outlier.size = 2, 
               alpha = 0.7) +
  coord_flip() +  # Flip axes for better readability
  labs(
    title = "Base Experience Distribution by Pokemon Type",
    x = "Pokemon Type",
    y = "Base Experience"
  ) +
  theme(legend.position = "none")  # Hide legend since fill is just for separation
```

------------------------------------------------------------------------

## **Saving and Exporting Data**

``` r
# Save cleaned data
write_csv(pokemon, "pokemon_data.csv")
#Save as Excel (.xlsx)
library(writexl)
write_xlsx(pokemon, "pokemon_data.xlsx")
# Save  last plot
setwd("Downloads/")
ggsave("weight_distribution.png", dpi = 300, width = 8, height = 6)
```

------------------------------------------------------------------------

### Some beautiful examples here:

<https://www.data-to-viz.com/>

![](https://attachments.convertkitcdnn2.com/1300146/4b522840-bd5d-4e58-b2f3-6042fb9fa9d6/poster-big.png)

# **Exercise**

1.  Create a plot to compare the **Attack** stats among Pokemon by their **primary type (`type_1`)**.

2.  Determine the number of Pokemon that **Gengar** can defeat and present the results in a table.

3.  Break down the number of Pokemon **Gengar** can defeat by their **primary type (`type_1`)** and display the results in a table.

4.  Identify the **most powerful Pokemon** and justify your decision using **data analysis and visualizations**. Support your reasoning with appropriate statistics and plots.
