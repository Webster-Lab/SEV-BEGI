#### read me ####

# The purpose of this script is for Christopher to process data to compare the fDOM and NPOC of metal matrix spike samples.
# 2026-05-28 CJO - I am making this script right now to create figures for my poster for tomorrow's (I know...) conference.

# NOTE: DO NOT push raw EXO1 files to the github repo! They are often too large for this. The purpose of the google drive workflow is to handle all these files, whereas github handles the scripts and condensed datasets :)
# The section below that "cleans up" the environment removes raw EXO files before pushing changes. 

#### libraries ####
library(tidyverse)

#### graphing from csv files for NPOC and fDOM ####
fDOM_csv <- read.csv("~/Documents/webster_lab/2026-05-21_fDOM-Fe-spikes.csv", header=T, fileEncoding="utf-8")
NPOC_csv <- read.csv("~/Documents/webster_lab/2026-05-21_NPOC-Fe-spikes.csv", header=T, fileEncoding="utf-8")

fDOMplot <- ggplot(fDOM_csv, aes(Fe2_spike_concentration_mgL, fDOM_QSU_relative)) +
  geom_point(size=5) +
  theme_bw() +
  theme(legend.position = "none",
        plot.title=element_text(size=30, face="bold"),
        axis.text=element_text(size=18),
        axis.title=element_text(size=24)) +
  labs(x="Fe(II) spike concentration (mg/L)", y="Relative signal of fDOM",
       title="Fe(II) effect on fDOM") +
  ylim(0.65,1)

ggsave("fDOMplot_relative.png", plot=fDOMplot, path="~/Documents/webster_lab/", width = 10, height = 7, units = "in", dpi=300)

NPOCplot <- ggplot(NPOC_csv, aes(Fe2_spike_concentration_mgL, NPOC_mgL_relative)) +
  geom_point(size=5) +
  theme_bw() +
  theme(legend.position = "none",
        plot.title=element_text(size=30, face="bold"),
        axis.text=element_text(size=18),
        axis.title=element_text(size=24)) +
  labs(x="Fe(II) spike concentration (mg/L)", y="Relative concentration of NPOC",
       title="Fe(II) effect on NPOC") +
  ylim(0.65,1)

ggsave("NPOCplot_relative.png", plot=NPOCplot, path="~/Documents/webster_lab/", width = 10, height = 7, units = "in", dpi=300)
