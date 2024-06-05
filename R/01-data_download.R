
#Import needed packages
library(tidyverse)
library(googlesheets4)

#Read data from google spreadsheet 
raw_data <- read_sheet("https://docs.google.com/spreadsheets/d/1UrfnA2PcXkvMsYdoWbbGFYt27GMrY7dn-wzcTUi_bnQ/edit?resourcekey#gid=2002407262")

#Save data to local directory
write_csv(raw_data, "data/raw/mensa_food_waste_raw.csv")
