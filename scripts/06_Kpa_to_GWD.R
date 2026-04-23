#### read me ####

# The purpose of this script is to transform pressure transducer readings into groundwater depth from the SEV-BEGI project. 
# This script is specifically for working with HOBO PT datasets.

# NOTE: DO NOT push raw PT files to the github repo! They are often too large for this. The purpose of the google drive workflow is to handle all these files, whereas github handles the scripts and condensed datasets :)
# The section below that "cleans up" the environment removes raw EXO files before pushing changes. 

#### libraries ####
library(googledrive) #so we can interface with Google files
library(tidyverse) #so we can a small amount of data transformation
library(lubridate) #so we can change transform date-time data

#### Load data ####
beep <- drive_get ("https://docs.google.com/spreadsheets/d/1wAyqjw8EDlK7sixdEHA1VMoKdQktFVlE/edit?usp=sharing&ouid=107567537261813068113&rtpof=true&sd=true8")

drive_download(beep, path = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/beeper_data.xlsx", overwrite = TRUE)

## need to manually save as csv file, need to figure out a automatic way to do this :)

beeper_data <- read.csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/beeper_data.csv") #read beeper data into R

kpa <- read.csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/04_raw_PT/corrected_Kpa_PT.csv")
kpa<-mutate(kpa, date = ymd_hms(date))

#### small clean ####
beeper <- beeper_data |>
  drop_na(casing_cm) |>
  unite(date, 1, 2, sep = " ") |>
  mutate(date = ymd_hms(date))|> #makes it POSTX format
  mutate(date = round_date(date, unit = "15 minute")) |># transforms all times to the closest 15 minutes  
  mutate(gwd = surface_cm - casing_cm)
   #drop any rows that do not have a date, can remove once we do more QA/QC on that dataset

ggplot(beeper, aes(date, gwd, color = well))+
  geom_point()+
  facet_wrap(~site)+
  theme_bw()

gwd_trend <- left_join(beeper, kpa, by = c("date", "well", "site"))
  
ggplot(gwd_trend, aes(Kpa_corr, gwd, color = well)) +
  geom_point()+
  facet_wrap(~site)+
  theme_bw()

avg_kpa <- left_join

ggplot()+
  geom_point(PT_data, aes(date, kpa))+
  geom_point(beeper_data, aes(date, surface))+
  facet_wrap(~site)

#### clean up before pushing to github ####
rm(list = ls()) #removing all things from the environment 


# now commit your changes and and push them to github!!