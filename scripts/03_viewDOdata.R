#### read me ####

# The purpose of this script is to compile and plot MX801 files from the SEV-BEGI project. 
# This script is specifically for working with HOBO DO datasets.
# This script was copied and modified from "SEV-BEGI/scripts/01_viewEXOtestdata.R"

# NOTE: DO NOT push raw EXO1 files to the github repo! They are often too large for this. The purpose of the google drive workflow is to handle all these files, whereas github handles the scripts and condensed datasets :)
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
raw_do_folder <- "https://drive.google.com/drive/folders/19KqRIbufpV_db2ONUmBIygI_6xK7JGXj?usp=drive_link" 

# make list of csv files only from "0_raw_MX801_csv" folder
ls_raw <- drive_ls(raw_do_folder, pattern = ".csv")

#tell R where I would like to save these files, save it to where ever you keep files locally
local <- "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/03_raw_MX801"

for (i in seq_along(ls_raw$name)) {  #create for loop for tibble 
  drive_download( #use googledrive package to download data
    as_id(ls_raw$id[[i]]), #name the folders as their names
    path = file.path(local, ls_raw$name[[i]]), #save it into local drive
    overwrite = TRUE #overwrite anything in there
  )
}

#### Add data to R and do a minor clean ####
#upload all data from local 03_raw_MX801 folder
do_list<- list.files(path = local, full.names = TRUE, pattern = ".csv") #turns into a list
do_data <- lapply(do_list, read_csv) #read all files into R

#creates a function that I can run on all my files listed
clean_do<- function(df) { 
  df |>
    rename(date = 2, temp = 3, do = 4) |> #renames cols to simpler names
    mutate(date = mdy_hms(date))|>
    mutate(date = round_date(date, unit = "5 minute")) |> # transforms all times to the nearest 5 mins
    filter(minute(date) %in% c(0, 15, 30, 45)) #removes any data that is not on the 0, 15, 30, or 45 minute mark (some of the earlier ones were set to log every 5 mins)
}

do_data <- lapply(do_data, clean_do) #applies the function we just made to all my data listed
names(do_data) <- sub("\\.csv$", "", basename(do_list)) #renames files to original files names

#### generate and save plots to local drive ###
for (i in seq_along(do_data)) {   # Make a for loop to make a plots for all data files
  p <- ggplot(do_data[[i]], aes(date, do)) + #plot by time and do
    geom_line() +
    labs(y = "Dissolved Oxygen mg/L",
         x= "Date",
         title = names(do_data)[i]) +
    theme_minimal()
  print(p)

plot_names <- paste0 ("plots/", names(do_data)[i], ".png") #make the plot names an object

ggsave(plot_names, plot = p,  path = local) #saves plots to local folder
}

#### upload plots to GoogleDrive from local folder ####
local_plots <- "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/03_raw_MX801/plots" #makes object out of local plot folder
plots_list <- list.files(path = local_plots, full.name = TRUE, pattern = ".png") #gets a list of all the files in that folder

for (i in plots_list) { #tell it to upload plots to GoogleDrive
  drive_upload(media = i, as_id("129YBdevfwctUWGH3aR-910ZFlam7VMqD", overwrite = TRUE))
}

#### clean up before pushing to github ####
rm(list = ls()) #removing all things from the environment 


# now commit your changes and and push them to github!!