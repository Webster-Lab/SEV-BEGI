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

## STOP, go and save that file as a csv manually!!!!! (until I add script here lol)

w_visits <- read_csv ("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/w_visits.csv")

#clean up disturbance data (need to finalize this)
w_visits <- w_visits |> #webster visits
  rename(date = 1, site = location, well = Position) |>
  select(1:7) |>
  filter(date >= as.Date('2025-10-01 00:00:00'), 
         observation == "removed", 
         !site %in% c("HARR", "CRAW")) |>
  mutate(well = paste(site, well, sep = ""), date = ymd_hms(paste(date, time)))
  
#plot data together by well
ggplot (do_data, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line(linewidth = 2) +
  facet_wrap(~well) +
  geom_vline(data = w_visits, 
             aes(xintercept = date), 
             color = "red", 
             linetype = "dashed", 
             alpha = 0.8)+
  theme_bw()+
  theme(legend.position = "none")

#select out data by site (need to make this a loop or purrr)
raw_ALAM <- filter(do_data, site == "ALAM")
ALAM_v <- filter(w_visits, site == "ALAM")

ggplot (raw_ALAM, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line(linewidth = 2) +
  facet_wrap(~well) +
  geom_vline(data = ALAM_v, aes(xintercept = date), color = "red", linetype = "dashed", alpha = 0.8)+
  theme_bw()+
  theme(legend.position = "none")

raw_MINN <- filter(do_data, site == "MINN")
MINN_v <- filter(w_visits, site == "MINN")

ggplot (raw_MINN, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line(linewidth = 2) +
  facet_wrap(~well) +
  geom_vline(data = MINN_v, aes(xintercept = date), color = "red", linetype = "dashed", alpha = 0.8)+
  theme_bw()+
  theme(legend.position = "none")

raw_RGNC <- filter(do_data, site == "RGNC")
RGNC_v <- filter(w_visits, site == "RGNC")

ggplot (raw_RGNC, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line(linewidth = 2) +
  facet_wrap(~well) +
  geom_vline(data = RGNC_v, aes(xintercept = date), color = "red", linetype = "dashed", alpha = 0.8)+
  theme_bw()+
  theme(legend.position = "none")

raw_SLO <- filter(do_data, site == "SLO")
SLO_v <- filter(w_visits, site == "SLO")

ggplot (raw_SLO, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line(linewidth = 2) +
  facet_wrap(~well) +
  geom_vline(data = SLO_v, aes(xintercept = date), color = "red", linetype = "dashed", alpha = 0.8)+
  theme_bw()+
  theme(legend.position = "none")


#### clean up before pushing to github ####
rm(list = ls()) #removing all things from the environment 


# now commit your changes and and push them to github!!
