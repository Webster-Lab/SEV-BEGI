
library(tidyverse)

data<- read_csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/maintenance_flagged/other/MINNW_flagged_.csv")

data <- data |>
  rename(datetime=TIMESTAMP)|>
  select(-c(SiteName))

ggplot(data, aes(datetime, do_mg_l, color = do_mg_l_flag))+
  geom_point()

ggplot(data[is.na(data$do_mg_l_flag),], aes(datetime, do_mg_l))+
  geom_point()

write_csv(data, file = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/maintenance_flagged/MINNW_flagged_20261106.csv")
