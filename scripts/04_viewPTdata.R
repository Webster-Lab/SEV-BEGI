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
