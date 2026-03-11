#### read me ####

# The purpose of this script is to combine MX DO datasets by site. 
# This script is specifically for working with MX DO datasets.
# This script was copied and modified from "SEV-BEGI/scripts/03_viewDOdata.R"

# NOTE: DO NOT push raw EXO1 files to the github repo! They are often too large for this. The purpose of the google drive workflow is to handle all these files, whereas github handles the scripts and condensed datasets :)
# The section below that "cleans up" the environment removes raw EXO files before pushing changes. 

#### libraries ####
library(tidyverse) #so we can a small amount of data transformation
library(lubridate) #so we can change transform date-time data

#### Add data to R and do a minor clean ####
#upload all data from local 03_raw_MX801 folder
local <-"~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/03_raw_MX801"
do_list<- list.files(path = local, full.names = TRUE, pattern = ".csv") #turns into a list
do_data <- do_list %>% 
  set_names(~sub("\\.csv$", "", basename(.))) %>% #sets name to original files
  map(read_csv) #reads in files to our environment

#creates a function that I can run on all my files listed
clean_do<- function(df) { 
  df |>
    rename(date = 2, temp_C = 3, do_mg_L = 4) |> #renames cols to simpler names
    mutate(date = mdy_hms(date))|>
    mutate(date = round_date(date, unit = "5 minute")) |> # transforms all times to the nearest 5 mins
    filter(minute(date) %in% c(0, 15, 30, 45)) #removes any data that is not on the 0, 15, 30, or 45 minute mark (some of the earlier ones were set to log every 5 mins)
}

do_data <- map(do_data, clean_do) #applies the function we just made to all my data listed

####Combine all dataframes so we can look at it ###
do_data <- do_data %>% 
  bind_rows (.id = "site") %>%
  mutate(site = str_extract(site, "[^_]+$")) #take the well id out by the name

ggplot (do_data, aes(date, do_mg_L, color = site)) + # view raw do by site
  geom_line() +
  facet_wrap(~site) +
  theme_bw()+
  theme(legend.position = "none")


#### clean up before pushing to github ####
rm(list = ls()) #removing all things from the environment 


# now commit your changes and and push them to github!!
