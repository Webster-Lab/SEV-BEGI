#### read me ####

# The purpose of this script is to combine MX DO datasets by site. 
# This script is specifically for working with MX DO datasets.
# This script was copied and modified from "SEV-BEGI/scripts/03_viewDOdata.R"

# NOTE: DO NOT push raw EXO1 files to the github repo! They are often too large for this. The purpose of the google drive workflow is to handle all these files, whereas github handles the scripts and condensed datasets :)
# The section below that "cleans up" the environment removes raw EXO files before pushing changes. 

#### libraries ####
library(googledrive) #so we can interface with Google files
library(tidyverse) #so we can a small amount of data transformation
library(lubridate) #so we can change transform date-time data

#### Add data to R ####
#add DO data
do_data <- read_csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/05_combined_cleaned/do_raw_combined.csv")

### Download disturbance data ###
dist <- drive_get ("https://docs.google.com/spreadsheets/d/1T3NfyaLZTzo4YIrDL2GRKJr_MzR5IzlW/edit?gid=1054504098#gid=1054504098")
drive_download(dist, path = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/w_visits.xlsx", overwrite = TRUE)
w_visits <- read_csv ("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/w_visits.csv")

#clean up distubance data
w_visits <- w_visits |>
  rename(date = 1) |>
  select(1:7) |>
  unite(well, 5, 6, sep = "") |>
  mutate(date = ymd_hms(paste(date, time))) |>
  filter(date >= as.Date('2025-10-01 00:00:00')) |>
  filter(observation == "removed")

ggplot (combined_do_data, aes(date, do_mg_L, color = site)) + # view raw do by site
  geom_line() +
  facet_wrap(~well) +
  geom_vline(data = w_visits, aes(xintercept = date, linetype = "dotted"))+
  theme_bw()+
  theme(legend.position = "none")

#### clean up before pushing to github ####
rm(list = ls()) #removing all things from the environment 


# now commit your changes and and push them to github!!
