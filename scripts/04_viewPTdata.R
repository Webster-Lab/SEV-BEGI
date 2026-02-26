#### read me ####

# The purpose of this script is to view and plot pressure transducer files from the SEV-BEGI project. 
# This script is specifically for working with HOBO PT datasets.
# This script was copied and modified from "SEV-BEGI/scripts/03_viewDOdata.R"

# NOTE: DO NOT push raw PT files to the github repo! They are often too large for this. The purpose of the google drive workflow is to handle all these files, whereas github handles the scripts and condensed datasets :)
# The section below that "cleans up" the environment removes raw EXO files before pushing changes. 

#### libraries ####
library(googledrive) #so we can interface with Google files
library(tidyverse) #so we can a small amount of data transformation
library(lubridate) #so we can change transform date-time data

#### load data from google drive #### potentially delete this
drive_auth() # log in to google from R

#choose 2 for authentication
2 

#### Download files into local folder ####
#define the google drive folder
raw_pt_folder <- "https://drive.google.com/drive/folders/1kBgaLh-fAJ2CVbO66JfrLg9muatqQ2jh?usp=drive_link"

# make list of csv files only from "0_raw_MX801_csv" folder
ls_raw <- drive_ls(raw_pt_folder, pattern = ".csv")

#tell R where I would like to save these files, save it to where ever you keep files locally
local <- "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/04_raw_PT"

for (i in seq_along(ls_raw$name)) {  #create for loop for tibble 
  drive_download( #use googledrive package to download data
    as_id(ls_raw$id[[i]]), #name the folders as their names
    path = file.path(local, ls_raw$name[[i]]), #save it into local drive
    overwrite = TRUE #overwrite anything in there
  )
}

#### Add data to R and do a minor clean ####
#upload all data from local 03_raw_MX801 folder
pt_list<- list.files(path = local, full.names = TRUE, pattern = ".csv") #turns into a list
pt_data <- lapply(pt_list, read_csv) #read all files into R

#creates a function that I can run on all my files listed
clean_pt<- function(df) { 
  df |>
    rename(date = 2, pressure = 3, temp = 4) |> #renames cols to simpler names
    mutate(date = mdy_hms(date))|>
    mutate(date = round_date(date, unit = "5 minute")) |> # transforms all times to the nearest 5 mins
    filter(minute(date) %in% c(0, 15, 30, 45)) #removes any data that is not on the 0, 15, 30, or 45 minute mark (some of the earlier ones were set to log every 5 mins)
}

pt_data <- lapply(pt_data, clean_pt) #applies the function we just made to all my data listed
names(pt_data) <- sub("\\.csv$", "", basename(pt_list)) #renames files to original files names

#### generate and save plots to local drive ###
for (i in seq_along(pt_data)) {   # Make a for loop to make a plots for all data files
  p <- ggplot(pt_data[[i]], aes(date, pressure)) + #plot by time and do
    geom_line() +
    labs(y = "Pressure (kPa)",
         x= "Date",
         title = names(pt_data)[i]) +
    theme_minimal()
  print(p)
  
  plot_names <- paste0 ("plots/", names(do_data)[i], ".png") #make the plot names an object
  
  ggsave(plot_names, plot = p,  path = local) #saves plots to local folder
