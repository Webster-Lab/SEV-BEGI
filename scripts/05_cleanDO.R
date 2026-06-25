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
do_data <- read_csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/05_combined_cleaned/20260624_raw_do.csv")

#add a date col to our do data
do_data <- do_data |> 
  mutate(datetime = date,
         date = date(datetime))


#### Download Webster Lab visits ####
webster <- drive_get ("https://docs.google.com/spreadsheets/d/1T3NfyaLZTzo4YIrDL2GRKJr_MzR5IzlW/edit?usp=sharing&ouid=107567537261813068113&rtpof=true&sd=true")
drive_download(webster, path = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/w_visits.xlsx", overwrite = TRUE)

#####################################################.
###STOP, go and save that file as a csv manually!!!!! 
#####################################################.

w_visits <- read_csv ("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/w_visits.csv")

#parse out deployment and removals 
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

#transform webster visits data so we can work with it easier
w_visits <- w_visits |> 
  group_by(well) |> 
  mutate(end = lead(datetime),
         next_status = lead(observation)) |>
  filter(
    observation == "removed", #make sure there is always a start and end time
    next_status == "deployed") |>
  transmute(date, site, well, start = datetime, end) |>
  ungroup()

#Visualize webster disturbance
#plot data together by well
ggplot () + # view raw do by site
  geom_line(data = do_data, aes(x = date, y = corr_do, color = well)) +
  # geom_rect(data = w_visits,
  #           aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf), fill = "red") +
  geom_vline(data = w_visits,
             aes(xintercept = start),
             color = "red",
             linetype = "dashed",
             alpha = 0.8)+
  facet_wrap(~site)+
  theme_bw()+
  theme(legend.position = "none")

#### Download BEMP visits ####
bemp <- drive_get ("https://docs.google.com/spreadsheets/d/1-lf5k0gRdYGa1wD27q3psIK4AIyqE4ZZxOStOdTGhAE/edit?usp=sharing")

drive_download(bemp, path = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/bemp_visits.xlsx", overwrite = TRUE)

#####################################################.
###STOP, go and save that file as a csv manually!!!!! 
#####################################################.

b_visits <- read_csv ("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/bemp_visits.csv")

b_visits<- b_visits |> #make the dataframe useful
  drop_na(date)|>
  mutate(end = ymd_hms(paste(date, time_end)),
         start= ymd_hms(paste(date, time_start)),
         date = ymd(date)) |>
  select(c(date, start, end, site))

well_names <- do_data |> #get unique well names
  distinct(site, well)

b_visits<- b_visits |> #add wells to bempo disturbance
  left_join(well_names, by = "site")

#Visualize BEMP
ggplot () + # view raw do by site to see if disturbances overlap
  geom_line(data = do_data, aes(x = date, y = corr_do, color = well)) +
  # geom_rect(data = b_visits,
  #            aes(xmin = date_start, xmax = date_end, ymin = -Inf, ymax = Inf), fill = "red") +
  geom_vline(data = b_visits,
             aes(xintercept = date, color = "red"),
             linetype = "dashed",
             alpha = 0.8)+
  facet_wrap(~site) +
  theme_bw()+
  theme(legend.position = "none")

## Look at the known disturbance data together 
ggplot (do_data, aes(date, do_mg_L, color = well)) + # view raw do by site
  geom_line() +
  geom_vline(data = b_visits, 
             aes(xintercept = start, color = "red"), 
             linetype = "dashed", 
             alpha = 0.8)+
  geom_vline(data = w_visits, 
             aes(xintercept = start), 
             color = "green", 
             linetype = "dashed", 
             alpha = 0.5)+
  facet_wrap(~site) +
  theme_bw()+
  theme(legend.position = "none")

#### flag data ####

#view data by well
by_well <- do_data |>
  group_by(well) |>
  group_split() |>
  set_names(well_names |>
              pull (well))

all_disturb <- w_visits |>
  bind_rows(b_visits) |>
  select(1:5) |>
  mutate(month = format(date, "%m"))

disturb_well <- all_disturb |>
  group_by(well) |>
  group_split()

plot_dist <- function(df, df2) {
  ggplot() +
    geom_line(data = df, aes(datetime, corr_do)) +
    geom_rect(data = df2,
              aes(xmin = start,
                  xmax = end,
                  ymin = -Inf, ymax = Inf),
              fill = "darkorange") +
    labs(title = unique(df$well)) +
    theme_bw() +
    theme(legend.position = "bottom")
}

mapply(plot_dist, by_well, well_distrub)

###upload data to r.shiny and flag any known disturbances

save_csv <- function(x) {
  write.csv(by_well[[x]], file = paste0("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/months/", x, ".csv"), row.names = FALSE)
}

lapply(names(by_well), save_csv)


#### Look at data by month (ONLY if if you haven't downloaded in a minute) ####
m_data <- do_data |>
  mutate(month = format(date, "%m"))

by_month <- m_data |>
  group_by(month, site) |>
  group_split() |>
  set_names(
    m_data |>
      group_by(month, site) |>
      summarise(.groups = "drop") |>
      mutate(name = paste0(month, "_", site)) |>
      pull(name))

all_disturb <- w_visits |>
  bind_rows(b_visits) |>
  select(1:5) |>
  mutate(month = format(date, "%m"))

dist_month <- all_disturb |>
  group_by(month, site) |>
  group_split() |>
  set_names(
    all_disturb |>
      group_by(month, site) |>
      summarise(.groups = "drop") |>
      mutate(name = paste0(month, "_", site)) |>
      pull(name))

shared<- intersect(names(by_month), names(dist_month))

plot <- function(df, df2) {
  ggplot() +
    geom_line(data = df, aes(datetime, corr_do, color = well)) +
    geom_rect(data = df2,
              aes(xmin = start,
                  xmax = end,
                  ymin = -Inf, ymax = Inf),
              fill = "darkorange") +
    facet_wrap(~well) +
    labs(title = unique(df$site)) +
    theme_bw() +
    theme(legend.position = "bottom")
}

month_plots <- mapply(plot,
  by_month[shared],
  dist_month[shared])

month_plots

by_month_well <- m_data |>
  group_by(month, well) |>
  group_split() |>
  set_names(
    m_data |>
      group_by(month, well) |>
      summarise(.groups = "drop") |>
      mutate(name = paste0(month, "_", well)) |>
      pull(name))

#Notes: Across all I need to write code to see how long it takes to brinf back to background measurments
#RGNC_11 Nov2 a disturbance? ask BEMP
#ALAMW_10 Oct19 distrubance?
#RGNC_05 May22 looks like she maybe went earlier like around the 19? bemp
#CRAW_05 May12 need to exclude May12 removal
#SLO_04 Disturbance around April 14
#RGNC_04 April 19? BEMP
#RGNC_03 March 17 BEMP?
#AOP_03 Seems like they went earlier than the PM?
#SLO_02 seems like they wenr earlier than they said
#AOP_02 seems earlier
#ALAM_02 need to look a web data

save_csv <- function(x) {
  write.csv(by_month_well[[x]], file = paste0("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/months/", x, ".csv"), row.names = FALSE)
}

lapply(names(by_month_well), save_csv)

#use shiny app to flag data



#### clean up before pushing to github ####

rm(list = ls()) #removing all things from the environment 


# now commit your changes and and push them to github!!
