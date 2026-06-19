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


#### Add DO data to R ####
#add DO data, make sure you add any new data as needed
do_data <- read_csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/05_combined_cleaned/20260615_raw_do.csv")

#### Download Webster Lab visits ####
dist <- drive_get ("https://docs.google.com/spreadsheets/d/1T3NfyaLZTzo4YIrDL2GRKJr_MzR5IzlW/edit?usp=sharing&ouid=107567537261813068113&rtpof=true&sd=true")
drive_download(dist, path = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/w_visits.xlsx", overwrite = TRUE)

## STOP, go and save that file as a csv manually!!!!! 
w_visits <- read_csv ("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/w_visits.csv")

#clean up disturbance data (need to finalize this)
w_visits<- w_visits |> #webster visits
  rename(date = 1, 
         site = location, 
         well = Position) |>
  select(1:7) |>
  mutate(well = paste(site, well, sep= ""),
         datetime = ymd_hm(paste(date, time)))|>
  filter(datetime >= as.Date('2025-10-01 00:00:00')) |> #remove any data before we started monitoring
  filter(model == "MX801-DO", 
         observation != "serviced")

#Visualize
#plot data together by well
ggplot (do_data, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line() +
  geom_vline(data = w_visits, 
             aes(xintercept = date), 
             color = "red", 
             linetype = "dashed", 
             alpha = 0.8)+
  facet_wrap(~well)+
  theme_bw()+
  theme(legend.position = "none")

#### Download BEMP visits ####
bemp_dist <- drive_get ("https://docs.google.com/spreadsheets/d/1-lf5k0gRdYGa1wD27q3psIK4AIyqE4ZZxOStOdTGhAE/edit?usp=sharing")

drive_download(bemp_dist, path = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/bemp_visits.xlsx", overwrite = TRUE)

## STOP, go and save that file as a csv manually!!!!! (until I add script here lol)

b_visits <- read_csv ("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/bemp_visits.csv")

b<- b_visits |>
  mutate(date_end = ymd_hms(paste(date, time_end, sep = " ")),
         date_start= ymd_hms(paste(date, time_start, sep = " ")),
         date = ymd(date)) |>
  drop_na(date)|>
  select(!c(time_start, time_end, `notes to Matt`))

#Visualize
#plot data together by well
ggplot (do_data, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line() +
  geom_vline(data = b_visits, 
             aes(xintercept = date, color = "red"), 
             linetype = "dashed", 
             alpha = 0.8)+
  facet_wrap(~site) +
  theme_bw()+
  theme(legend.position = "none")

#### Combine data ####

## Look at the disturbance data together 
ggplot (do_data, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line() +
  geom_vline(data = b_visits, 
             aes(xintercept = date, color = "red"), 
             linetype = "dashed", 
             alpha = 0.8)+
  geom_vline(data = w_visits, 
             aes(xintercept = date), 
             color = "green", 
             linetype = "dashed", 
             alpha = 0.8)+
  facet_wrap(~site) +
  theme_bw()+
  theme(legend.position = "none")

ggplot () + # view raw do by site
  geom_rect(data = b, 
            aes(xmin = date_start, xmax = date_end, ymin = -Inf, ymax = Inf, fill = "grey"),
            alpha = .5) +
  geom_line(data = cleaned, 
            aes(x = datetime, y = do_mg_L, color = well)) +
  facet_wrap(~site) +
  theme_bw()+
  theme(legend.position = "none")

#transform webster visits data so we can work with it easier
w<- w_visits |> 
  group_by(well) |> 
  mutate(end_date = lead(datetime),
         next_status = lead(observation)) |>
  filter(
    observation == "removed", #make sure there is always a start and end time
    next_status == "deployed") |>
  transmute(date, site, well, start_date = datetime, end_date) |>
  ungroup()

#add a date col to our do data
data <- do_data |> 
  mutate(datetime = date,
         date = date(datetime))

#join do and webster data together
d <- data |>
left_join(w, by = join_by (date, site, well)) |>
  mutate(disturb = between(datetime, start_date, end_date)) |> #mark whenever timews in the datetime col are between the sart and end times
  mutate(disturb = if_else(is.na(disturb), F, disturb)) |>
  mutate(disturb = if_else(disturb, "w", ""))

noweb <- d |>
  filter(disturb != "w")

ggplot(noweb, aes(datetime, do_mg_L, color = well))+
  geom_line()+
  facet_wrap(~site)+
  theme_bw()
  

#join do, web and bemp data 
d2 <- d |>
  select(!c(start_date, end_date)) |>
  left_join(b, by = join_by (date, site)) |>
  mutate(disturb2 = between(datetime, date_start, date_end)) |>
  mutate(disturb2 = if_else(is.na(disturb2), F, disturb2)) |>
  mutate(disturb2 = if_else(disturb2 == T, "b", "")) |>
  mutate(flag = paste(disturb, disturb2)) |>
  select(!c(date_start, date_end, disturb, disturb2)) |>
  transmute(date, datetime, site, well, do_mg_L, temp_C, flag)

cleaned <- d2 |>
  mutate(do_mg_L = if_else(flag != " ", NA, do_mg_L))
  
##### Plot by site ####
site_clean <- cleaned |>
  group_split(site) #make a list by site

site <- d2 |>
  group_split(site) #make a list by site

plot_site_clean <- function(df, bdf) {
  ggplot() +
    geom_rect(data = bdf, 
              aes(xmin = date_start, xmax = date_end, ymin = -Inf, ymax = Inf, fill = "grey"),
              alpha = .5) +
    geom_line(df, aes(datetime, do_mg_L, color = well)) +
    facet_wrap(~ site) +
    theme_bw() +
    theme(legend.position = "none")
}

lapply (site_clean, plot_site_clean, bdf = b)

plot_site_clean(site_clean [[1]], b)

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
