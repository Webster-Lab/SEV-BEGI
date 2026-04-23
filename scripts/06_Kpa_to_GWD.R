#### read me ####

# The purpose of this script is to transform pressure transducer readings into groundwater depth from the SEV-BEGI project. 
# This script is specifically for working with HOBO PT datasets.

# NOTE: DO NOT push raw PT files to the github repo! They are often too large for this. The purpose of the google drive workflow is to handle all these files, whereas github handles the scripts and condensed datasets :)
# The section below that "cleans up" the environment removes raw EXO files before pushing changes. 


#### transform kpa to ground water depth ####
beep <- drive_get ("https://docs.google.com/spreadsheets/d/1wAyqjw8EDlK7sixdEHA1VMoKdQktFVlE/edit?usp=sharing&ouid=107567537261813068113&rtpof=true&sd=true8")
drive_download(beep, path = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/beeper_data.xlsx", overwrite = TRUE)

## need to manually save as csv file

beeper_data <- read.csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/beeper_data.csv")

beeper_data <- beeper_data |>
  unite(date, 1, 2, sep = " ") |>
  mutate(date = mdy_hms(date))|> #makes it POSTX format
  mutate(date = round_date(date, unit = "5 minute")) |> # transforms all times to the
  
  avg_kpa <- PT_data |>
  group_by(date, well)|>
  summarise(pressure_mean = mean(pressure_Kpa))

avg_kpa <- left_join

ggplot()+
  geom_point(PT_data, aes(date, kpa))+
  geom_point(beeper_data, aes(date, surface))+
  facet_wrap(~site)

#### clean up before pushing to github ####
rm(list = ls()) #removing all things from the environment 


# now commit your changes and and push them to github!!