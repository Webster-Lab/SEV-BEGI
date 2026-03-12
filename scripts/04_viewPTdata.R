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

#### load data from google drive ####
drive_auth() # log in to google from R

#choose 2 for authentication
2 

#### Download files into local folder ####

## Water PT ##
#define the google drive folder
raw_air <- "https://drive.google.com/drive/folders/1b2so7b-buPsGlyic_Fup3j_m39zUYmnS?usp=drive_link"

# make list of csv files only from "Air PTs" folder
ls_air <- drive_ls(raw_air, pattern = ".csv")

#tell R where I would like to save these files, save it to where ever you keep files locally
local_air <- "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/04_raw_PT/raw_air_PT"

for (a in seq_along(ls_air$name)) {  #create for loop for tibble 
  drive_download( #use googledrive package to download data
    as_id(ls_air$id[[a]]), #name the folders as their names
    path = file.path(local_air, ls_air$name[[a]]), #save it into local drive
    overwrite = TRUE #overwrite anything in there
  )
}

## Water PT ##
#define the google drive folder
raw_water <- "https://drive.google.com/drive/folders/1kBgaLh-fAJ2CVbO66JfrLg9muatqQ2jh?usp=drive_link"

# make list of csv files only from "0_raw_MX801_csv" folder
ls_water <- drive_ls(raw_water, pattern = ".csv")

#tell R where I would like to save these files, save it to where ever you keep files locally
local_water <- "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/04_raw_PT/raw_water_PT"

for (w in seq_along(ls_water$name)) {  #create for loop for tibble 
  drive_download( #use googledrive package to download data
    as_id(ls_water$id[[w]]), #name the folders as their names
    path = file.path(local_water, ls_water$name[[w]]), #save it into local drive
    overwrite = TRUE #overwrite anything in there
  )
}

#### Add data to R and do a minor clean ####
#upload all data from local PT folders
air_list<- list.files(path = local_air, full.names = TRUE, pattern = ".csv") #turns into a list
air_data <- lapply(air_list, read_csv) #read all files into R

water_list<- list.files(path = local_water, full.names = TRUE, pattern = ".csv") #turns into a list
water_data <- lapply(water_list, read_csv) #read all files into R

#creates a function that I can run on all my files listed
names(air_data) <- sub("\\.csv$", "", basename(air_list)) #renames files to original files names
names(water_data) <- sub("\\.csv$", "", basename(water_list))

clean_pt<- function(df) { 
  df |>
    rename(date = 2, pressure_Kpa = 3, temp_C = 4) |> #renames cols to simpler names
    mutate(date = mdy_hms(date))|> #makes it POSTX format
    mutate(date = round_date(date, unit = "5 minute")) |> # transforms all times to the nearest 5 mins
    filter(minute(date) %in% c(0, 15, 30, 45)) #removes any data that is not on the 0, 15, 30, or 45 minute mark (some of the earlier ones were set to log every 5 mins)
}

air_data <- lapply(air_data, clean_pt) #applies the function we just made to all my data listed
water_data <- lapply(water_data, clean_pt)

combined_water_data <- water_data %>% #combine data
  bind_rows (.id = "site") %>%
  mutate(well = str_extract(site, "[^_]+$"), #take the well id out by the name
  site = str_sub(well, 1, -2)) #take site id out of well id

combined_air_data <- air_data %>% #combine data
  bind_rows (.id = "site") %>%
  mutate(well = str_extract(site, "[^_]+$"), #take the well id out by the name
         site = str_extract(site, "(?<=_)[^_]+(?=_[^_]+$)"))

#### Plot out the raw data ####

#plot it all
ggplot(combined_water_data, aes(date, pressure_Kpa, color = well))+
  geom_line(data = combined_water_data)+
  geom_line(data = combined_air_data, aes(date, pressure_Kpa))+
  facet_wrap(~site)+
  theme_bw()+
  theme(legend.position = "none")

#plot by site 


#### generate and save plots to local drive ####
for (i in seq_along(pt_data)) {   # Make a for loop to make a plots for all data files
  p <- ggplot(pt_data[[i]], aes(date, pressure)) + #plot by time and do
    geom_line() +
    labs(y = "Pressure (kPa)",
         x= "Date",
         title = names(pt_data)[i]) +
    theme_minimal()
  print(p)
  
  plot_names <- paste0 ("plots/", names(pt_data)[i], ".png") #make the plot names an object
  
  ggsave(plot_names, plot = p,  path = local) #saves plots to local folder
  
}

#### clean up before pushing to github ####
rm(list = ls()) #removing all things from the environment 


# now commit your changes and and push them to github!!