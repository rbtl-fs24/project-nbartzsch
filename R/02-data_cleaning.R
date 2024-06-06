
#Load packages
library(tidyverse)
library(readr)
library(forcats)

#Import a copy of the raw data
mensa_food_waste_clean <- read_csv("data/raw/mensa_food_waste_raw.csv")

#Rename columns to meaningful names
mensa_food_waste_clean <- mensa_food_waste_clean |>
  rename(time = Timestamp,
         conditions = `The data collected will be used anonymously for a published report as part of the course. Non of your personal data will be shared, stored or collected.`,
         fw_concern = `How concerned are you with food waste?`,
         less_menus = `Would you consider having less menu options at Polymensa in favor of less food waste?`,
         eating_freq = `How often do you eat at the Polymensa in a typical week (lunch and dinner included)?`,
         menu_choice = `Which factor plays the biggest role in your menu choice?`,
         fw_today = `When eating at the Polymensa nowadays, how often do you have food left over on your plate?`,
         larger_serving = `If there was an option for a larger serving with an increased price, how often would you choose the larger serving`,
         smaller_serving = `If there was an option for a smaller serving with a reduced price, how often would you choose the smaller serving`,
         second_serving = `Previously there was the possibility to get a second serving for certain menus. 
How common was it for you to take another serving of food?`,
         new_portions = `With the restriction on second servings, do you perceive the initial portion sizes to be larger, smaller, or about the same as before?`,
         compare_fw = `Have you noticed a significant change in the amount of food waste you generate at the Polymensa after the policy change disallowing second servings?`)

#Filter out entries that do not accept conditions and 
mensa_food_waste_clean <- mensa_food_waste_clean |>
  filter(conditions == "I read and understood the conditions listed above and want to voluntarily participate in this survey")

#Remove conditions column afterwards since only valid participants are included and remove time since not relevant for analysis
mensa_food_waste_clean <- mensa_food_waste_clean |>
  select(-conditions,
         -time)

#Add id column
mensa_food_waste_clean <- mensa_food_waste_clean |>
  mutate(id = 1:nrow(mensa_food_waste_clean), .before = 1)

#Create levels vector to transform chr into fct
levels_fw_concern <-  c("Very Concerned",
                        "Concerned",
                        "Moderately concerned",
                        "Slightly concerned",
                        "Not concerned at all")
levels_less_menus <-  c("Yes",
                        "No")
levels_menu_choice <-  c("Taste",
                        "Price",
                        "Nutritional values",
                        "Sustainability",
                        "Regional Products",
                        "Organic Products",
                        "Dietary restrictions",
                        "Variety/ Novelty",
                        "other")
levels_fw_today <-  c("Always",
                      "Often",
                      "Sometimes",
                      "Rarely",
                      "Never")
levels_smaller_serving <-  c("Always",
                             "Often",
                             "Sometimes",
                             "Rarely",
                             "Never")
levels_larger_serving <-  c("Always",
                             "Often",
                             "Sometimes",
                             "Rarely",
                             "Never")
levels_second_serving <-  c("Always",
                             "Often",
                             "Sometimes",
                             "Rarely",
                             "Never")
levels_new_portions <-  c("Larger",
                             "About the same",
                             "Smaller")
levels_compare_fw <-  c("Increase in food waste",
                        "Same food waste",
                        "Decrease in food waste")
                             
#Change variable type to fct
mensa_food_waste_clean <-  mensa_food_waste_clean |>
  mutate(fw_concern = factor(fw_concern, levels_fw_concern),
         less_menus = factor(less_menus, levels_less_menus),
         menu_choice = factor(menu_choice, levels_menu_choice),
         fw_today = factor(fw_today, levels_fw_today),
         smaller_serving = factor(smaller_serving, levels_smaller_serving),
         larger_serving = factor(larger_serving, levels_larger_serving),
         second_serving = factor(second_serving, levels_second_serving),
         new_portions = factor(new_portions, levels_new_portions),
         compare_fw = factor(compare_fw, levels_compare_fw))

#Save clean data to repo
write_csv(mensa_food_waste_clean, "data/processed/processed_data.csv")

#Create data for the summary table
tbl_data <-  mensa_food_waste_clean |>
  summarise(
    mean = mean(eating_freq),
    median = median(eating_freq),
    min = min(eating_freq),
    max = max(eating_freq)
  )
#Save data to final folder
write_csv(tbl_data, "data/final/table_data.csv")

#Edit data to create data for figure 1
fig_1_data <- mensa_food_waste_clean |>
  mutate(fw_today = fct_recode(fw_today,
                                 "1" = "Never",
                                 "2" = "Rarely",
                                 "3" = "Sometimes",
                                 "4" = "Often",
                                 "5" = "Always"),
         smaller_serving = fct_recode(smaller_serving,
                               "1" = "Never",
                               "2" = "Rarely",
                               "3" = "Sometimes",
                               "4" = "Often",
                               "5" = "Always"))
#Save data to final folder
write_csv(fig_1_data, "data/final/fig_1_data.csv")

#Edit data to create data for figure 2
fig_2_data <-  mensa_food_waste_clean |>
  mutate(second_serving = fct_recode(second_serving,
                               "1" = "Never",
                               "2" = "Rarely",
                               "3" = "Sometimes",
                               "4" = "Often",
                               "5" = "Always"))
#Save data to final folder
write_csv(fig_2_data, "data/final/fig_2_data.csv")
  
  
