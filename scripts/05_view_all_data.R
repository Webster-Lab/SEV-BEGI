

library(dataRetrieval)
library(tidyverse)
library(ggplot2)


##### Upload DO flagged data ####
do_list<- list.files(path = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/maintenance_flagged", full.names = TRUE, pattern = ".csv")

do_data <- do_list |> 
  set_names(~sub("\\.csv$", "", basename(.))) |> #sets name to original files
  lapply(read_csv) 

#bind them together
do_bind<- do_data |> 
  bind_rows ()


#check them out
ggplot(do_bind, aes(datetime, do_mg_l, color = well))+
  geom_point()+
  facet_wrap(~well)


##### Upload corrected PT data ####

PT<- read_csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/05_combined_cleaned/20261018_corr_PT")

PT<- PT |>
  select(!c(1,3)) |>
  rename(datetime = date, temp_C_PT = temp_C)

ggplot(PT, aes(datetime, pressure_Kpa, color = site)) +
  geom_point() +
  facet_wrap ( ~well)

ggplot(PT, aes(datetime, corr_Kpa, color = site)) +
  geom_point() +
  facet_wrap ( ~well)

#### Combine them #####

data <- left_join(do_bind, PT, by = c("well", "site", "datetime"))

ggplot(data, aes(x = datetime, color = well))+
  geom_point(aes(y = do_mg_l)) +
  geom_point(aes(y = pressure_Kpa))+
  facet_wrap( ~site)

#### Remove flags ####

#see what it looks like without the flags
data_flag <-data |>
  filter(is.na(flag))

ggplot(data_flag, aes(x = datetime, color = well))+
  geom_point(aes(y = do_mg_l)) +
  geom_point(aes(y = pressure_Kpa))+
  facet_wrap( ~site)

#### Break it up by well #####

data_well <- data_flag |>
  group_by(well) |>
  group_split()

names(data_well) <- sapply(data_well, \(x) unique(x$well)) #extract the names to name new data sets

for (i in seq_along(data_well)) {   # Make a for loop to make do plots for all data files
  plots <- ggplot(data_well[[i]], aes(x = datetime, do_mg_l, color = site)) +
    geom_point(do_mg_l, color = site) +                      
    labs(y = "Dissolved Oxygen mg/L",
         x= "Date",
         title = names(data_well)[i]) +
    theme_bw() 
  
  print (plots)}

# Make a for loop to make do plots for all data files

max_pressure <- sapply(data_well, function(df) max(df$pressure_Kpa, na.rm = TRUE))

for (i in seq_along(data_well)) {
  plots <- ggplot(data_well[[i]], aes(x = datetime)) +
    geom_point(aes(y = do_mg_l), color = "blue") +
    geom_point(aes(y = (113-pressure_Kpa)), color = "red") +
    scale_y_continuous(
      name = "DO (mg/L)",
      sec.axis = sec_axis(
        ~ . ,
        name = "'Depth to ground water' (113-Kpa)")
    )+
    labs(y = "Kpa",
         x= "Date",
         title = names(data_well)[i]) +
    theme_bw()
    
  print (plots)}
  
#### Add USGS stream guage data ####

usgs_sites <- c("USGS-08330000")

 # "USGS-08329918")   #Rio Grande at Alameda Bridge at Alameda
                #"USGS-08330000"),   #Rio Grande at Albuquerque
                # "USGS-08330830",   #Rio Grande at Valle de Oro
                # "USGS-08331160",   #Rio Grande near Bosque Farms
                # "USGS-08354900")   #Rio Grande Floodway at San Acacia

## BEGI Sites to USGS Guages ##
#  MINN & ALAM   08329918  
#  RGNC & AOP    08330000
#  HARR & SLO    08330830   
#  BOSF & LOLU   08331160   
#  SEV           08354900

flow <- read_waterdata_continuous(
  monitoring_location_id = usgs_sites,
  parameter_code = "00060",
  time = c("2025-10-17", NA))
  
flow <- flow |>
  select(c(monitoring_location_id, time, value)) |>
  rename("usgs" = "monitoring_location_id", "datetime" = "time", "flow_cfs" = "value") |>
  filter(between(datetime, as.Date("2025-10-18"), as.Date("2026-9-25")))

ggplot(flow, aes(datetime, flow_cfs), color = "blue") +
  geom_line()+
  theme_bw()


wells <- do_data |>
  group_by(well) |>
  group_split()

names(wells) <- sapply(wells, \(x) unique(x$well)) #extract the names to name new data sets
