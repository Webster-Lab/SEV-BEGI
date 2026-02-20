#### read me ####

# The purpose of this script is to compile and plot MX801 files from the SEV-BEGI project. 
# This script is specifically for working with HOBO DO datasets.
# This script was copied and modified from "SEV-BEGI/scripts/01_viewEXOtestdata.R"

# NOTE: DO NOT push raw EXO1 files to the github repo! They are often too large for this. The purpose of the google drive workflow is to handle all these files, whereas github handles the scripts and condensed datasets :)
# The section below that "cleans up" the environment removes raw EXO files before pushing changes. 

#### libraries ####
library(googledrive)
library(tidyverse)
library(lubridate)


#### load data from google drive ####
drive_auth() # log in to google from R
2 #choose 2

# make lsit of csv files only from "0_raw_MX801_csv" folder
ls_tibble <- drive_ls("https://drive.google.com/drive/folders/19KqRIbufpV_db2ONUmBIygI_6xK7JGXj?usp=drive_link", pattern = ".csv")

#tell R where I would like to save these files
path <- "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/SEV_BEGI/Data/00_raw_MX801_csv"

#Download all files into local drive
for (i in seq_along(ls_tibble$name)) {
  drive_download(
    as_id(ls_tibble$id[[i]]),
    path = file.path(path, ls_tibble$name[[i]]),
    overwrite = TRUE
  )
}

#Set working directory to that local drive, you must do this to get the function to work
setwd ("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/SEV_BEGI/Data/00_raw_MX801_csv")

local<-"~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/SEV_BEGI/Data/00_raw_MX801_csv" #set pathway

#upload all data from working directory
do_list<- list.files(full.names = TRUE) #turns into a list
do_data <- lapply(do_list, read_csv) #read all files into R

#creates a function that I can run on all my files listed
clean_do<- function(df) { 
  df |>
    rename(date = 2, temp = 3, do = 4) |> #renames cols to simplier names
    mutate(date = mdy_hms(date))|>
    mutate(date = round_date(date, unit = "5 minute")) |> # transforms all times to the nearest 5 mins
    filter(minute(date) %in% c(0, 15, 30, 45)) #removes any data that is not on the 0, 15, 30, or 45 minute mark (some of the earlier ones were set to log every 5 mins)
}

do_data <- lapply(do_data, clean_do) #applys the function we just made to all my data listed
names(do_data) <- sub("\\.csv$", "", basename(do_list)) #renames files to original files names

for (i in seq_along(do_data)) {
  p <- ggplot(do_data[[i]], aes(date, do)) +
    geom_line() +
    labs(title = names(do_data)[i]) +
    theme_minimal()
  
  print(p)
}
