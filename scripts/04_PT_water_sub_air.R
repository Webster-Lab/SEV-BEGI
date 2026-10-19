
#### libraries ####
library(googledrive) #so we can interface with Google files
library(tidyverse) #so we can do data transformation

#### Add PT data to R ####
#add PT data, make sure you add any new data as needed

PT <- read_csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/05_combined_cleaned/20261018_raw_PT")
air <- read_csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/05_combined_cleaned/20261018_raw_air")

#### by well ###
PT_site <- PT |>
  group_by(site) |>
  group_split()

names(PT_site) <- sapply(PT_site, \(x) unique(x$site)) #extract the names to name new data sets

air_site <- air |>
  group_by(well) |>
  group_split()

names(air_site) <- sapply(air_site, \(x) unique(x$well)) #extract the names to name new data sets

#### Subtract air from water ####
# ALAM_AIR -> ALAM, MINN, RGNC -> UP
# SLO_AIR -> AOP, HARR, SLO, BOSF, LOLU -> MID
# SEV_AIR -> CRAW, SEV -> LOW

air_map <- c(ALAM = "ALAM_AIR", MINN = "ALAM_AIR",  RGNC = "ALAM_AIR",
             AOP = "SLO_AIR", HARR = "SLO_AIR", SLO = "SLO_AIR", BOSF = "SLO_AIR", LOLU = "SLO_AIR",
             CRAW = "SEV_AIR", SEV = "SEV_AIR")

corrected <- lapply(names(PT_site), \(nm) {
  a <- air_site[[air_map[[nm]]]] |> select(date, air_Kpa)
  PT_site[[nm]] |>
    left_join(a, by = "date") |>
    mutate(corr_Kpa = pressure_Kpa - air_Kpa)
}) |> setNames(names(PT_site))

corr_combined <- bind_rows(corrected)

#### NOTE: Need to figure out how to add missing Kpa for site before we deployed the air PT's, particular the UP grouping

write_csv(corr_combined, "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/05_combined_cleaned/20261018_corr_PT")

