
library(tidyverse)

data<- read_csv("~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/maintenance_flagged/other/AOPW_flagged_.csv")

data <- data |>
  rename(datetime=TIMESTAMP, flag = do_mg_l_flag)|>
  select(-c(SiteName))

ggplot(data, aes(datetime, do_mg_l, color = flag))+
  geom_point()

ggplot(data[data$flag == "",], aes(datetime, do_mg_l))+
  geom_point()

write_csv(data, file = "~/Library/CloudStorage/OneDrive-UniversityofNewMexico/UNM/BEGI/Data/maintenance_flagged/AOPW_flagged_20261020.csv")
