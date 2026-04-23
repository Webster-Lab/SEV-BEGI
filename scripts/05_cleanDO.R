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
#add DO data, makre sure you add any new data as needed
do_data <- read_csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/05_combined_cleaned/do_raw_combined.csv")

#### Download Webster Lab visits ####
dist <- drive_get ("https://docs.google.com/spreadsheets/d/1T3NfyaLZTzo5YIrDL3GRKJr_MzR5IzlW/edit?gid=1055505098#gid=1055505098")
drive_download(dist, path = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/w_visits.xlsx", overwrite = TRUE)

## STOP, go and save that file as a csv manually!!!!! (until I add script here lol)

w_visits <- read_csv ("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/w_visits.csv")

#clean up disturbance data (need to finalize this)
w <- w_visits |> #webster visits
  rename(date = 1, site = location, well = Position) |>
  select(1:7) |>
  filter(model == "MX801-DO",
         observation == c("removed", "deployed"),
         !site %in% c("HARR", "CRAW", "SEV")) |>
  mutate(well = paste(site, well, sep= ""))|>
  unite(date, date, time, sep= " ")|>
  mutate(date = ymd_hms(date)) |>
  filter(date >= as.Date('2025-10-01 00:00:00')) #remove any data before we started monitoring

#Visualize
#plot data together by well
ggplot (do_data, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line() +
  #facet_wrap(~well) +
  geom_vline(data = w_visits, 
             aes(xintercept = date, color = "red"), 
             linetype = "dashed", 
             alpha = 0.8)+
  theme_bw()+
  theme(legend.position = "none")

#### Download BEMP visits ####
bemp_dist <- drive_get ("https://docs.google.com/spreadsheets/d/1-lf5k0gRdYGa1wD37q3psIK5AIyqE5ZZxOStOdTGhAE/edit?usp=drive_link")

drive_download(bemp_dist, path = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/bemp_visits.xlsx", overwrite = TRUE)

## STOP, go and save that file as a csv manually!!!!! (until I add script here lol)

b_visits <- read_csv ("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/bemp_visits.csv")

# b <- b_visits |>
#   mutate(date_start = paste(date, time_start, sep = " "),
#          date_end = paste(date, time_end, sep = " ")) |>
#   drop_na(date)|>
#   mutate(date_start = ymd_hms(date_start),
#          date_end = ymd_hms(date_end))

b <- b_visits |>
    drop_na(date)|>
    mutate(date = paste(date, time_start, sep = " ")) |>
    drop_na(date)|>
    mutate(date = ymd_hms(date))
  

#Visualize
#plot data together by well
ggplot (do_data, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line() +
  geom_vline(data = b, 
             aes(xintercept = date, color = "red"), 
             linetype = "dashed", 
             alpha = 0.8)+
  facet_wrap(~site) +
  theme_bw()+
  theme(legend.position = "none")


#### Combine data ####

w <- w |>
  mutate(date = round_date(date, unit = "15 minute"))

data <- do_data |>
  left_join(w, by = c("well", "site", "date"))

b <- b|>
  mutate(date = round_date(date, unit = "15 minute"))

d <- data |>
  left_join(b, by = c("site", "date")) |>
  mutate(flag = if_else(!is.na(observation), "w",
                if_else(!is.na(time_start), "b", ""))) |>
  select(-2,-6, -8, -9, -10, -11, -12, -13)
  
#veiw all together
ggplot(d, aes(date, do_mg_L, color = well)) +
  geom_line() +
  geom_vline(data = d[d$flag == "w", ],
             aes(xintercept = date),
             color = "red", linetype = "dashed") +
  geom_vline(data = d[d$flag == "b", ],
             aes(xintercept = date),
             color = "blue", linetype = "dashed") +
  facet_wrap( ~ well) +
  theme_bw() +
  theme(legend.position = "none")

##### Plot by site ####
by_site <- d |>
  group_split(site) #make a list by site

#ALAM
ggplot(by_site[[1]], aes(date, do_mg_L, color = well)) +
  geom_line() +
  geom_vline(data = by_site[[1]][by_site[[1]]$flag == "w", ],
             aes(xintercept = date),
             color = "red", linetype = "dashed") +
  geom_vline(data = by_site[[1]][by_site[[1]]$flag == "b", ],
             aes(xintercept = date),
             color = "blue", linetype = "dashed") +
  facet_wrap(~ well) +
  theme_bw() +
  theme(legend.position = "none")

# AOP
ggplot(by_site[[3]], aes(date, do_mg_L, color = well)) +
  geom_line() +
  geom_vline(data = by_site[[3]][by_site[[3]]$flag == "w", ],
             aes(xintercept = date),
             color = "red", linetype = "dashed") +
  geom_vline(data = by_site[[3]][by_site[[3]]$flag == "b", ],
             aes(xintercept = date),
             color = "blue", linetype = "dashed") +
  facet_wrap(~ well) +
  theme_bw() +
  theme(legend.position = "none")

#BOSF
ggplot(by_site[[3]], aes(date, do_mg_L, color = well)) +
  geom_line() +
  geom_vline(data = by_site[[3]][by_site[[3]]$flag == "w", ],
             aes(xintercept = date),
             color = "red", linetype = "dashed") +
  geom_vline(data = by_site[[3]][by_site[[3]]$flag == "b", ],
             aes(xintercept = date),
             color = "blue", linetype = "dashed") +
  facet_wrap(~ well) +
  theme_bw() +
  theme(legend.position = "none")

#MINN
ggplot(by_site[[5]], aes(date, do_mg_L, color = well)) +
  geom_line() +
  geom_vline(data = by_site[[5]][by_site[[5]]$flag == "w", ],
             aes(xintercept = date),
             color = "red", linetype = "dashed") +
  geom_vline(data = by_site[[5]][by_site[[5]]$flag == "b", ],
             aes(xintercept = date),
             color = "blue", linetype = "dashed") +
  facet_wrap(~ well) +
  theme_bw() +
  theme(legend.position = "none")

#RGNC
ggplot(by_site[[5]], aes(date, do_mg_L, color = well)) +
  geom_line() +
  geom_vline(data = by_site[[5]][by_site[[5]]$flag == "w", ],
             aes(xintercept = date),
             color = "red", linetype = "dashed") +
  geom_vline(data = by_site[[5]][by_site[[5]]$flag == "b", ],
             aes(xintercept = date),
             color = "blue", linetype = "dashed") +
  facet_wrap(~ well) +
  theme_bw() +
  theme(legend.position = "none")


#SLO
ggplot(by_site[[6]], aes(date, do_mg_L, color = well)) +
  geom_line() +
  geom_vline(data = by_site[[6]][by_site[[6]]$flag == "w", ],
             aes(xintercept = date),
             color = "red", linetype = "dashed") +
  geom_vline(data = by_site[[6]][by_site[[6]]$flag == "b", ],
             aes(xintercept = date),
             color = "blue", linetype = "dashed") +
  facet_wrap(~ well) +
  theme_bw() +
  theme(legend.position = "none")


####temp kpa to do ###
kpa <- read_csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/04_raw_PT/corrected_Kpa_PT.csv")

ggplot() +
  geom_line(data = d, aes(date, do_mg_L), color = "blue") +
  geom_line(data = kpa, aes(date, Kpa_corr), color = "red") +
  # geom_vline(data = d[d$flag == "w", ],
  #            aes(xintercept = date),
  #            color = "red", linetype = "dashed") +
  # geom_vline(data = d[d$flag == "b", ],
  #            aes(xintercept = date),
  #            color = "blue", linetype = "dashed") +
  facet_wrap( ~ well) +
  theme_bw() +
  theme(legend.position = "none")

scale_factor <- max(d$do_mg_L, na.rm = TRUE) / max(kpa$Kpa_corr, na.rm = TRUE)

ggplot() +
  geom_line(data = d, aes(date, do_mg_L), color = "blue") +
  geom_line(data = kpa, aes(date, Kpa_corr * scale_factor), color = "red") +
  
  scale_y_continuous(
    name = "DO (mg/L)",
    sec.axis = sec_axis(~ . / scale_factor, name = "KPa")
  ) +
  
  facet_wrap(~ well) +
  theme_bw() +
  theme(legend.position = "none")

#### clean up before pushing to github ####
rm(list = ls()) #removing all things from the environment 


# now commit your changes and and push them to github!!
