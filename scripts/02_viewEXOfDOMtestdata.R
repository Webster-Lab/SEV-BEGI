#### read me ####

# The purpose of this script is to compile and plot EXO1 files from the SEV-BEGI project. 
# This script is specifically for working with datasets from testing fDOM-metal interactions.
# This script was copied and modified from "SEV-BEGI/scripts/01_viewEXOtestdata.R"

# NOTE: DO NOT push raw EXO1 files to the github repo! They are often too large for this. The purpose of the google drive workflow is to handle all these files, whereas github handles the scripts and condensed datasets :)
# The section below that "cleans up" the environment removes raw EXO files before pushing changes. 

#### libraries ####
library(googledrive)
library(tidyverse)
library(zoo)

#### load data from google drive ####

# Now is a good time to pull changes from GitHub :)

# make sure that googledrive_data folder exists, because it seems like it disappears...

# delete all formally downloaded EXO files
# NOTE: It is STRONGLY recommended that you delete all your local raw EXO1 files from the last time you downloaded them from google drive, then use the script below to import them anew EACH TIME you run this script. This assures that files are the unaltered files saved to google drive each time, and there are no discrepancies between what is being analyzed and what is in our google drive repositories by different people. We DO save and push complied and cleaned data in the repo so it can be used in the next step of analysis, but we don't need to keep the raw files anywhere but on google drive.
# get all files in the directories, recursively
f <- list.files("googledrive_data/", include.dirs = F, full.names = T, recursive = T)
# remove the files
file.remove(f)

# download csv files only from "Roan's test data" folder
ls_tibble <- googledrive::drive_ls("https://drive.google.com/drive/folders/1yaWdohEDKCaa30qQlYn0UeqFG-YFZTkc", type = "csv")

2 # to give permission
path <- "googledrive_data/"
for (i in seq_along(ls_tibble$name)) {
  drive_download(
    as_id(ls_tibble$id[[i]]),
    path = file.path(path, ls_tibble$name[[i]]),
    overwrite = TRUE
  )
}

#### load data into R ####

# pick the file you want to view
# EXO files have several rows before the actual column headers and data. You must skip the number of rows, which is typically 8 or 9 unless something funky happened. If you get an error on this line, check the file for how many rows you need to skip.
# EXO files also use non-standard characters in headers that upset R. You must save files in UTF-8 encoded format to avoid this. If you get an error, check the encoding of the file and resave it as UTF-8 if needed. IF YOU DO THIS, MAKE SURE YOU REPLACE THE FILE IN GOOGLE DRIVE TOO SO THAT IT DOESN'T MESS UP THE NEXT PERSON!!!!!

SLOWintrinsic = read.csv("googledrive_data/20251119_3231_intrinsic.csv", skip=9, header=T,
                       fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"

SLOWFe0.1ppm = read.csv("googledrive_data/20251119_3231_Fe-0.1ppm-added.csv", skip=9, header=T,
                         fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOWFe0.2ppm = read.csv("googledrive_data/20251119_3231_Fe-0.2ppm-added.csv", skip=9, header=T,
                        fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOWFe0.5ppm = read.csv("googledrive_data/20251119_3231_Fe-0.5ppm-added.csv", skip=9, header=T,
                        fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOWFe1ppm = read.csv("googledrive_data/20251119_3231_Fe-1ppm-added.csv", skip=9, header=T,
                        fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOWFe10ppm = read.csv("googledrive_data/20251119_3231_Fe-10ppm-added.csv", skip=9, header=T,
                        fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOWFe50ppm = read.csv("googledrive_data/20251119_3231_Fe-50ppm-added.csv", skip=9, header=T,
                        fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"

SLOWMn0.1ppm = read.csv("googledrive_data/20251119_3231_Mn-0.1ppm-added.csv", skip=9, header=T,
                        fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOWMn0.2ppm = read.csv("googledrive_data/20251119_3231_Mn-0.2ppm-added.csv", skip=9, header=T,
                        fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOWMn0.5ppm = read.csv("googledrive_data/20251119_3231_Mn-0.5ppm-added.csv", skip=9, header=T,
                        fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOWMn1ppm = read.csv("googledrive_data/20251119_3231_Mn-1ppm-added.csv", skip=9, header=T,
                      fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOWMn10ppm = read.csv("googledrive_data/20251119_3231_Mn-10ppm-added.csv", skip=9, header=T,
                       fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOWMn50ppm = read.csv("googledrive_data/20251119_3231_Mn-50ppm-added.csv", skip=9, header=T,
                       fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"

SLOW1.5xDilution = read.csv("googledrive_data/20251119_3231_1.5x-dilution.csv", skip=9, header=T,
                       fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOW2xDilution = read.csv("googledrive_data/20251119_3231_2x-dilution.csv", skip=9, header=T,
                            fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOW3xDilution = read.csv("googledrive_data/20251119_3231_3x-dilution.csv", skip=9, header=T,
                          fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOW5xDilution = read.csv("googledrive_data/20251119_3231_5x-dilution.csv", skip=9, header=T,
                          fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"
SLOW10xDilution = read.csv("googledrive_data/20251119_3231_10x-dilution.csv", skip=9, header=T,
                          fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"


######################
#### format dates ####

#### SLOWintrinsic ####
# put date and time in same column
SLOWintrinsic$datetime = paste(SLOWintrinsic$Date..MM.DD.YYYY.,  SLOWintrinsic$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWintrinsic$datetimeMT = as.POSIXct(SLOWintrinsic$datetime, 
                                     format = "%m/%d/%Y %H:%M:%S",
                                     tz="US/Mountain")
# check that results are reasonable
summary(SLOWintrinsic$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWintrinsic = SLOWintrinsic[!is.na(SLOWintrinsic$datetimeMT),]


#### SLOWFe0.1ppm ####
# put date and time in same column
SLOWFe0.1ppm$datetime = paste(SLOWFe0.1ppm$Date..MM.DD.YYYY.,  SLOWFe0.1ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWFe0.1ppm$datetimeMT = as.POSIXct(SLOWFe0.1ppm$datetime, 
                                      format = "%m/%d/%Y %H:%M:%S",
                                      tz="US/Mountain")
# check that results are reasonable
summary(SLOWFe0.1ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWFe0.1ppm = SLOWFe0.1ppm[!is.na(SLOWFe0.1ppm$datetimeMT),]


#### SLOWFe0.2ppm ####
# put date and time in same column
SLOWFe0.2ppm$datetime = paste(SLOWFe0.2ppm$Date..MM.DD.YYYY.,  SLOWFe0.2ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWFe0.2ppm$datetimeMT = as.POSIXct(SLOWFe0.2ppm$datetime, 
                                     format = "%m/%d/%Y %H:%M:%S",
                                     tz="US/Mountain")
# check that results are reasonable
summary(SLOWFe0.2ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWFe0.2ppm = SLOWFe0.2ppm[!is.na(SLOWFe0.2ppm$datetimeMT),]

#### SLOWFe0.5ppm ####
# put date and time in same column
SLOWFe0.5ppm$datetime = paste(SLOWFe0.5ppm$Date..MM.DD.YYYY.,  SLOWFe0.5ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWFe0.5ppm$datetimeMT = as.POSIXct(SLOWFe0.5ppm$datetime, 
                                     format = "%m/%d/%Y %H:%M:%S",
                                     tz="US/Mountain")
# check that results are reasonable
summary(SLOWFe0.5ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWFe0.5ppm = SLOWFe0.5ppm[!is.na(SLOWFe0.5ppm$datetimeMT),]

#### SLOWFe1ppm ####
# put date and time in same column
SLOWFe1ppm$datetime = paste(SLOWFe1ppm$Date..MM.DD.YYYY.,  SLOWFe1ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWFe1ppm$datetimeMT = as.POSIXct(SLOWFe1ppm$datetime, 
                                     format = "%m/%d/%Y %H:%M:%S",
                                     tz="US/Mountain")
# check that results are reasonable
summary(SLOWFe1ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWFe1ppm = SLOWFe1ppm[!is.na(SLOWFe1ppm$datetimeMT),]

#### SLOWFe10ppm ####
# put date and time in same column
SLOWFe10ppm$datetime = paste(SLOWFe10ppm$Date..MM.DD.YYYY.,  SLOWFe10ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWFe10ppm$datetimeMT = as.POSIXct(SLOWFe10ppm$datetime, 
                                   format = "%m/%d/%Y %H:%M:%S",
                                   tz="US/Mountain")
# check that results are reasonable
summary(SLOWFe10ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWFe10ppm = SLOWFe10ppm[!is.na(SLOWFe10ppm$datetimeMT),]

#### SLOWFe50ppm ####
# put date and time in same column
SLOWFe50ppm$datetime = paste(SLOWFe50ppm$Date..MM.DD.YYYY.,  SLOWFe50ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWFe50ppm$datetimeMT = as.POSIXct(SLOWFe50ppm$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOWFe50ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWFe50ppm = SLOWFe50ppm[!is.na(SLOWFe50ppm$datetimeMT),]



#### SLOWMn0.1ppm ####
# put date and time in same column
SLOWMn0.1ppm$datetime = paste(SLOWMn0.1ppm$Date..MM.DD.YYYY.,  SLOWMn0.1ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWMn0.1ppm$datetimeMT = as.POSIXct(SLOWMn0.1ppm$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOWMn0.1ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWMn0.1ppm = SLOWMn0.1ppm[!is.na(SLOWMn0.1ppm$datetimeMT),]


#### SLOWMn0.2ppm ####
# put date and time in same column
SLOWMn0.2ppm$datetime = paste(SLOWMn0.2ppm$Date..MM.DD.YYYY.,  SLOWMn0.2ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWMn0.2ppm$datetimeMT = as.POSIXct(SLOWMn0.2ppm$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOWMn0.2ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWMn0.2ppm = SLOWMn0.2ppm[!is.na(SLOWMn0.2ppm$datetimeMT),]

#### SLOWMn0.5ppm ####
# put date and time in same column
SLOWMn0.5ppm$datetime = paste(SLOWMn0.5ppm$Date..MM.DD.YYYY.,  SLOWMn0.5ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWMn0.5ppm$datetimeMT = as.POSIXct(SLOWMn0.5ppm$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOWMn0.5ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWMn0.5ppm = SLOWMn0.5ppm[!is.na(SLOWMn0.5ppm$datetimeMT),]

#### SLOWMn1ppm ####
# put date and time in same column
SLOWMn1ppm$datetime = paste(SLOWMn1ppm$Date..MM.DD.YYYY.,  SLOWMn1ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWMn1ppm$datetimeMT = as.POSIXct(SLOWMn1ppm$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOWMn1ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWMn1ppm = SLOWMn1ppm[!is.na(SLOWMn1ppm$datetimeMT),]

#### SLOWMn10ppm ####
# put date and time in same column
SLOWMn10ppm$datetime = paste(SLOWMn10ppm$Date..MM.DD.YYYY.,  SLOWMn10ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWMn10ppm$datetimeMT = as.POSIXct(SLOWMn10ppm$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOWMn10ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWMn10ppm = SLOWMn10ppm[!is.na(SLOWMn10ppm$datetimeMT),]

#### SLOWMn50ppm ####
# put date and time in same column
SLOWMn50ppm$datetime = paste(SLOWMn50ppm$Date..MM.DD.YYYY.,  SLOWMn50ppm$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWMn50ppm$datetimeMT = as.POSIXct(SLOWMn50ppm$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOWMn50ppm$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOWMn50ppm = SLOWMn50ppm[!is.na(SLOWMn50ppm$datetimeMT),]

#### SLOW1.5xDilution ####
# put date and time in same column
SLOW1.5xDilution$datetime = paste(SLOW1.5xDilution$Date..MM.DD.YYYY.,  SLOW1.5xDilution$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOW1.5xDilution$datetimeMT = as.POSIXct(SLOW1.5xDilution$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOW1.5xDilution$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOW1.5xDilution = SLOW1.5xDilution[!is.na(SLOW1.5xDilution$datetimeMT),]

#### SLOW2xDilution ####
# put date and time in same column
SLOW2xDilution$datetime = paste(SLOW2xDilution$Date..MM.DD.YYYY.,  SLOW2xDilution$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOW2xDilution$datetimeMT = as.POSIXct(SLOW2xDilution$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOW2xDilution$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOW2xDilution = SLOW2xDilution[!is.na(SLOW2xDilution$datetimeMT),]

#### SLOW3xDilution ####
# put date and time in same column
SLOW3xDilution$datetime = paste(SLOW3xDilution$Date..MM.DD.YYYY.,  SLOW3xDilution$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOW3xDilution$datetimeMT = as.POSIXct(SLOW3xDilution$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOW3xDilution$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOW3xDilution = SLOW3xDilution[!is.na(SLOW3xDilution$datetimeMT),]

#### SLOW5xDilution ####
# put date and time in same column
SLOW5xDilution$datetime = paste(SLOW5xDilution$Date..MM.DD.YYYY.,  SLOW5xDilution$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOW5xDilution$datetimeMT = as.POSIXct(SLOW5xDilution$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOW5xDilution$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOW5xDilution = SLOW5xDilution[!is.na(SLOW5xDilution$datetimeMT),]

#### SLOW10xDilution ####
# put date and time in same column
SLOW10xDilution$datetime = paste(SLOW10xDilution$Date..MM.DD.YYYY.,  SLOW10xDilution$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOW10xDilution$datetimeMT = as.POSIXct(SLOW10xDilution$datetime, 
                                    format = "%m/%d/%Y %H:%M:%S",
                                    tz="US/Mountain")
# check that results are reasonable
summary(SLOW10xDilution$datetimeMT)
# may not need this, but NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
# SLOW10xDilution = SLOW10xDilution[!is.na(SLOW10xDilution$datetimeMT),]

#####################################
#### compile bursts within 1 min ####

#### SLOWintrinsic ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWintrinsic)
# SLOWintrinsic[5:22] = as.numeric(SLOWintrinsic[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWintrinsic$datetimeMT, "minute")
SLOWintrinsic.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOWintrinsic, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWintrinsic.comp$datetimeMT<-as.POSIXct(SLOWintrinsic.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")
#### SLOWFe0.1ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWFe0.1ppm)
# SLOWFe0.1ppm[5:22] = as.numeric(SLOWFe0.1ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWFe0.1ppm$datetimeMT, "minute")
SLOWFe0.1ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                            fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                            ODO...sat,ODO...local,ODO.mg.L,
                                                            Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                            TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                            Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                      ~ min, SLOWFe0.1ppm, na.action=na.pass, 
                                                      FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWFe0.1ppm.comp$datetimeMT<-as.POSIXct(SLOWFe0.1ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")
#### SLOWFe0.2ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWFe0.2ppm)
# SLOWFe0.2ppm[5:22] = as.numeric(SLOWFe0.2ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWFe0.2ppm$datetimeMT, "minute")
SLOWFe0.2ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                           fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                           ODO...sat,ODO...local,ODO.mg.L,
                                                           Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                           TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                           Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                     ~ min, SLOWFe0.2ppm, na.action=na.pass, 
                                                     FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWFe0.2ppm.comp$datetimeMT<-as.POSIXct(SLOWFe0.2ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")
#### SLOWFe0.5ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWFe0.5ppm)
# SLOWFe0.5ppm[5:22] = as.numeric(SLOWFe0.5ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWFe0.5ppm$datetimeMT, "minute")
SLOWFe0.5ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                           fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                           ODO...sat,ODO...local,ODO.mg.L,
                                                           Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                           TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                           Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                     ~ min, SLOWFe0.5ppm, na.action=na.pass, 
                                                     FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWFe0.5ppm.comp$datetimeMT<-as.POSIXct(SLOWFe0.5ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOWFe1ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWFe1ppm)
# SLOWFe1ppm[5:22] = as.numeric(SLOWFe1ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWFe1ppm$datetimeMT, "minute")
SLOWFe1ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                           fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                           ODO...sat,ODO...local,ODO.mg.L,
                                                           Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                           TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                           Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                     ~ min, SLOWFe1ppm, na.action=na.pass, 
                                                     FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWFe1ppm.comp$datetimeMT<-as.POSIXct(SLOWFe1ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOWFe10ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWFe10ppm)
# SLOWFe10ppm[5:22] = as.numeric(SLOWFe10ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWFe10ppm$datetimeMT, "minute")
SLOWFe10ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                         fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                         ODO...sat,ODO...local,ODO.mg.L,
                                                         Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                         TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                         Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                   ~ min, SLOWFe10ppm, na.action=na.pass, 
                                                   FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWFe10ppm.comp$datetimeMT<-as.POSIXct(SLOWFe10ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOWFe50ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWFe50ppm)
# SLOWFe50ppm[5:22] = as.numeric(SLOWFe50ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWFe50ppm$datetimeMT, "minute")
SLOWFe50ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOWFe50ppm, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWFe50ppm.comp$datetimeMT<-as.POSIXct(SLOWFe50ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")


#### SLOWMn0.1ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWMn0.1ppm)
# SLOWMn0.1ppm[5:22] = as.numeric(SLOWMn0.1ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWMn0.1ppm$datetimeMT, "minute")
SLOWMn0.1ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOWMn0.1ppm, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWMn0.1ppm.comp$datetimeMT<-as.POSIXct(SLOWMn0.1ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")


#### SLOWMn0.2ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWMn0.2ppm)
# SLOWMn0.2ppm[5:22] = as.numeric(SLOWMn0.2ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWMn0.2ppm$datetimeMT, "minute")
SLOWMn0.2ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOWMn0.2ppm, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWMn0.2ppm.comp$datetimeMT<-as.POSIXct(SLOWMn0.2ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOWMn0.5ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWMn0.5ppm)
# SLOWMn0.5ppm[5:22] = as.numeric(SLOWMn0.5ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWMn0.5ppm$datetimeMT, "minute")
SLOWMn0.5ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOWMn0.5ppm, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWMn0.5ppm.comp$datetimeMT<-as.POSIXct(SLOWMn0.5ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOWMn1ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWMn1ppm)
# SLOWMn1ppm[5:22] = as.numeric(SLOWMn1ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWMn1ppm$datetimeMT, "minute")
SLOWMn1ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOWMn1ppm, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWMn1ppm.comp$datetimeMT<-as.POSIXct(SLOWMn1ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOWMn10ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWMn10ppm)
# SLOWMn10ppm[5:22] = as.numeric(SLOWMn10ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWMn10ppm$datetimeMT, "minute")
SLOWMn10ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOWMn10ppm, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWMn10ppm.comp$datetimeMT<-as.POSIXct(SLOWMn10ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOWMn50ppm ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWMn50ppm)
# SLOWMn50ppm[5:22] = as.numeric(SLOWMn50ppm[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOWMn50ppm$datetimeMT, "minute")
SLOWMn50ppm.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOWMn50ppm, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWMn50ppm.comp$datetimeMT<-as.POSIXct(SLOWMn50ppm.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOW1.5xDilution ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOW1.5xDilution)
# SLOW1.5xDilution[5:22] = as.numeric(SLOW1.5xDilution[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOW1.5xDilution$datetimeMT, "minute")
SLOW1.5xDilution.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOW1.5xDilution, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOW1.5xDilution.comp$datetimeMT<-as.POSIXct(SLOW1.5xDilution.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOW2xDilution ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOW2xDilution)
# SLOW2xDilution[5:22] = as.numeric(SLOW2xDilution[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOW2xDilution$datetimeMT, "minute")
SLOW2xDilution.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOW2xDilution, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOW2xDilution.comp$datetimeMT<-as.POSIXct(SLOW2xDilution.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOW3xDilution ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOW3xDilution)
# SLOW3xDilution[5:22] = as.numeric(SLOW3xDilution[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOW3xDilution$datetimeMT, "minute")
SLOW3xDilution.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOW3xDilution, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOW3xDilution.comp$datetimeMT<-as.POSIXct(SLOW3xDilution.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOW5xDilution ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOW5xDilution)
# SLOW5xDilution[5:22] = as.numeric(SLOW5xDilution[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOW5xDilution$datetimeMT, "minute")
SLOW5xDilution.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOW5xDilution, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOW5xDilution.comp$datetimeMT<-as.POSIXct(SLOW5xDilution.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

#### SLOW10xDilution ####
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOW10xDilution)
# SLOW10xDilution[5:22] = as.numeric(SLOW10xDilution[5:22]) << this doesn't seem to work but I'm leaving it in
# get means and standard deviations of numeric burst values
min<-round_date(SLOW10xDilution$datetimeMT, "minute")
SLOW10xDilution.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm,Depth.m,
                                                          fDOM.QSU,fDOM.RFU,nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Pressure.psi.a,Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Vertical.Position.m,Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOW10xDilution, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOW10xDilution.comp$datetimeMT<-as.POSIXct(SLOW10xDilution.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

###########################################################
#### complete timeseries with all possible time stamps ####

# this is a helpful step to assure that you have a row for every possible time point that should be in the data set. If there are any breaks in the data, this will allow them to be identified and potentially interpolated, and it will also prevent plotting errors and other issues that come up when working with time series. 

#### SLOWintrinsic ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWintrinsic.comp$datetimeMT),
    to = max(SLOWintrinsic.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWintrinsic.comp$datetimeMT<- lubridate::round_date(SLOWintrinsic.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWintrinsic.ts = left_join(time, SLOWintrinsic.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWintrinsic.comp$datetimeMT))


#### SLOWFe0.1ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWFe0.1ppm.comp$datetimeMT),
    to = max(SLOWFe0.1ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWFe0.1ppm.comp$datetimeMT<- lubridate::round_date(SLOWFe0.1ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWFe0.1ppm.ts = left_join(time, SLOWFe0.1ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWFe0.1ppm.comp$datetimeMT))
#### SLOWFe0.2ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWFe0.2ppm.comp$datetimeMT),
    to = max(SLOWFe0.2ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWFe0.2ppm.comp$datetimeMT<- lubridate::round_date(SLOWFe0.2ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWFe0.2ppm.ts = left_join(time, SLOWFe0.2ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWFe0.2ppm.comp$datetimeMT))
#### SLOWFe0.5ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWFe0.5ppm.comp$datetimeMT),
    to = max(SLOWFe0.5ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWFe0.5ppm.comp$datetimeMT<- lubridate::round_date(SLOWFe0.5ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWFe0.5ppm.ts = left_join(time, SLOWFe0.5ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWFe0.5ppm.comp$datetimeMT))
#### SLOWFe1ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWFe1ppm.comp$datetimeMT),
    to = max(SLOWFe1ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWFe1ppm.comp$datetimeMT<- lubridate::round_date(SLOWFe1ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWFe1ppm.ts = left_join(time, SLOWFe1ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWFe1ppm.comp$datetimeMT))
#### SLOWFe10ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWFe10ppm.comp$datetimeMT),
    to = max(SLOWFe10ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWFe10ppm.comp$datetimeMT<- lubridate::round_date(SLOWFe10ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWFe10ppm.ts = left_join(time, SLOWFe10ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWFe10ppm.comp$datetimeMT))
#### SLOWFe50ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWFe50ppm.comp$datetimeMT),
    to = max(SLOWFe50ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWFe50ppm.comp$datetimeMT<- lubridate::round_date(SLOWFe50ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWFe50ppm.ts = left_join(time, SLOWFe50ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWFe50ppm.comp$datetimeMT))

#### SLOWMn0.1ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWMn0.1ppm.comp$datetimeMT),
    to = max(SLOWMn0.1ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWMn0.1ppm.comp$datetimeMT<- lubridate::round_date(SLOWMn0.1ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWMn0.1ppm.ts = left_join(time, SLOWMn0.1ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWMn0.1ppm.comp$datetimeMT))

#### SLOWMn0.2ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWMn0.2ppm.comp$datetimeMT),
    to = max(SLOWMn0.2ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWMn0.2ppm.comp$datetimeMT<- lubridate::round_date(SLOWMn0.2ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWMn0.2ppm.ts = left_join(time, SLOWMn0.2ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWMn0.2ppm.comp$datetimeMT))
#### SLOWMn0.5ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWMn0.5ppm.comp$datetimeMT),
    to = max(SLOWMn0.5ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWMn0.5ppm.comp$datetimeMT<- lubridate::round_date(SLOWMn0.5ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWMn0.5ppm.ts = left_join(time, SLOWMn0.5ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWMn0.5ppm.comp$datetimeMT))

#### SLOWMn1ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWMn1ppm.comp$datetimeMT),
    to = max(SLOWMn1ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWMn1ppm.comp$datetimeMT<- lubridate::round_date(SLOWMn1ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWMn1ppm.ts = left_join(time, SLOWMn1ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWMn1ppm.comp$datetimeMT))

#### SLOWMn10ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWMn10ppm.comp$datetimeMT),
    to = max(SLOWMn10ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWMn10ppm.comp$datetimeMT<- lubridate::round_date(SLOWMn10ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWMn10ppm.ts = left_join(time, SLOWMn10ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWMn10ppm.comp$datetimeMT))

#### SLOWMn50ppm ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWMn50ppm.comp$datetimeMT),
    to = max(SLOWMn50ppm.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOWMn50ppm.comp$datetimeMT<- lubridate::round_date(SLOWMn50ppm.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOWMn50ppm.ts = left_join(time, SLOWMn50ppm.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOWMn50ppm.comp$datetimeMT))

#### SLOW1.5xDilution ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOW1.5xDilution.comp$datetimeMT),
    to = max(SLOW1.5xDilution.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOW1.5xDilution.comp$datetimeMT<- lubridate::round_date(SLOW1.5xDilution.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOW1.5xDilution.ts = left_join(time, SLOW1.5xDilution.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOW1.5xDilution.comp$datetimeMT))

#### SLOW2xDilution ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOW2xDilution.comp$datetimeMT),
    to = max(SLOW2xDilution.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOW2xDilution.comp$datetimeMT<- lubridate::round_date(SLOW2xDilution.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOW2xDilution.ts = left_join(time, SLOW2xDilution.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOW2xDilution.comp$datetimeMT))

#### SLOW3xDilution ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOW3xDilution.comp$datetimeMT),
    to = max(SLOW3xDilution.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOW3xDilution.comp$datetimeMT<- lubridate::round_date(SLOW3xDilution.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOW3xDilution.ts = left_join(time, SLOW3xDilution.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOW3xDilution.comp$datetimeMT))

#### SLOW5xDilution ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOW5xDilution.comp$datetimeMT),
    to = max(SLOW5xDilution.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOW5xDilution.comp$datetimeMT<- lubridate::round_date(SLOW5xDilution.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOW5xDilution.ts = left_join(time, SLOW5xDilution.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOW5xDilution.comp$datetimeMT))

#### SLOW10xDilution ####
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOW10xDilution.comp$datetimeMT),
    to = max(SLOW10xDilution.comp$datetimeMT),
    by = "1 min" ))
# make sure all time stamps in data set are rounded to nearest 1 min 
SLOW10xDilution.comp$datetimeMT<- lubridate::round_date(SLOW10xDilution.comp$datetimeMT, "1 minute") 
# join to clean time stamps
SLOW10xDilution.ts = left_join(time, SLOW10xDilution.comp, by="datetimeMT")

# check for duplicate time stamps - FALSE is good!
any(duplicated(SLOW10xDilution.comp$datetimeMT))

##################
#### plotting ####

#### plot - SLOWintrinsic ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWintrinsic-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWintrinsic.ts$datetimeMT, tz="US/Mountain"),(SLOWintrinsic.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWintrinsic.ts$datetimeMT, tz="US/Mountain"),(SLOWintrinsic.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWintrinsic.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWintrinsic.ts$datetimeMT, tz="US/Mountain"),(SLOWintrinsic.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWintrinsic.ts$datetimeMT, tz="US/Mountain"),(SLOWintrinsic.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWintrinsic.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWintrinsic.ts$datetimeMT, tz="US/Mountain"),(SLOWintrinsic.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWintrinsic.ts$datetimeMT, tz="US/Mountain"),(SLOWintrinsic.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWintrinsic.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWintrinsic.ts$datetimeMT, tz="US/Mountain"),(SLOWintrinsic.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWintrinsic.ts$datetimeMT, tz="US/Mountain"),(SLOWintrinsic.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWintrinsic.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWintrinsic.ts$datetimeMT, tz="US/Mountain"),(SLOWintrinsic.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWintrinsic.ts$datetimeMT, tz="US/Mountain"),(SLOWintrinsic.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWintrinsic.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()

#### plot - SLOWFe0.1ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWFe0.1ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWFe0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.1ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.1ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWFe0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.1ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.1ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWFe0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.1ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.1ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWFe0.1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWFe0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.1ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.1ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWFe0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.1ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.1ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOWFe0.2ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWFe0.2ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWFe0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.2ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.2ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.2ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWFe0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.2ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.2ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.2ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWFe0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.2ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.2ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWFe0.2ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWFe0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.2ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.2ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.2ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWFe0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.2ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.2ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.2ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOWFe0.5ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWFe0.5ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWFe0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.5ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.5ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.5ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWFe0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.5ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.5ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.5ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWFe0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.5ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.5ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWFe0.5ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWFe0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.5ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.5ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.5ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWFe0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.5ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe0.5ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe0.5ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOWFe1ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWFe1ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWFe1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe1ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe1ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWFe1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe1ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe1ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWFe1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe1ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe1ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWFe1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWFe1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe1ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe1ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWFe1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe1ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe1ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOWFe10ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWFe10ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWFe10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe10ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe10ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe10ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWFe10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe10ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe10ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe10ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWFe10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe10ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe10ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWFe10ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWFe10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe10ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe10ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe10ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWFe10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe10ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe10ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe10ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOWFe50ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWFe50ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWFe50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe50ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe50ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe50ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWFe50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe50ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe50ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe50ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWFe50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe50ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe50ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWFe50ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWFe50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe50ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe50ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe50ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWFe50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe50ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWFe50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWFe50ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWFe50ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()

#### plot - SLOWMn0.1ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWMn0.1ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWMn0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.1ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.1ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWMn0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.1ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.1ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWMn0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.1ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.1ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWMn0.1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWMn0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.1ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.1ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWMn0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.1ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.1ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOWMn0.2ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWMn0.2ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWMn0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.2ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.2ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.2ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWMn0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.2ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.2ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.2ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWMn0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.2ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.2ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWMn0.2ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWMn0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.2ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.2ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.2ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWMn0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.2ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.2ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.2ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.2ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOWMn0.5ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWMn0.5ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWMn0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.5ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.5ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.5ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWMn0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.5ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.5ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.5ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWMn0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.5ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.5ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWMn0.5ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWMn0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.5ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.5ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.5ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWMn0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.5ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn0.5ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn0.5ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn0.5ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOWMn1ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWMn1ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWMn1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn1ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn1ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWMn1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn1ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn1ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWMn1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn1ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn1ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWMn1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWMn1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn1ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn1ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWMn1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn1ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn1ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn1ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn1ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOWMn10ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWMn10ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWMn10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn10ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn10ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn10ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWMn10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn10ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn10ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn10ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWMn10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn10ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn10ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWMn10ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWMn10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn10ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn10ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn10ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWMn10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn10ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn10ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn10ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn10ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOWMn50ppm ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOWMn50ppm-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWMn50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn50ppm.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn50ppm.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn50ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWMn50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn50ppm.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn50ppm.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn50ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOWMn50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn50ppm.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn50ppm.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWMn50ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWMn50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn50ppm.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn50ppm.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn50ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWMn50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn50ppm.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWMn50ppm.ts$datetimeMT, tz="US/Mountain"),(SLOWMn50ppm.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWMn50ppm.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOW1.5xDilution ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOW1.5xDilution-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOW1.5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW1.5xDilution.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW1.5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW1.5xDilution.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW1.5xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOW1.5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW1.5xDilution.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW1.5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW1.5xDilution.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW1.5xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOW1.5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW1.5xDilution.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW1.5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW1.5xDilution.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOW1.5xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOW1.5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW1.5xDilution.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW1.5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW1.5xDilution.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW1.5xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOW1.5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW1.5xDilution.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW1.5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW1.5xDilution.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW1.5xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOW2xDilution ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOW2xDilution-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOW2xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW2xDilution.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW2xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW2xDilution.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW2xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOW2xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW2xDilution.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW2xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW2xDilution.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW2xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOW2xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW2xDilution.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW2xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW2xDilution.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOW2xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOW2xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW2xDilution.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW2xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW2xDilution.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW2xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOW2xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW2xDilution.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW2xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW2xDilution.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW2xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOW3xDilution ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOW3xDilution-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOW3xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW3xDilution.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW3xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW3xDilution.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW3xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOW3xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW3xDilution.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW3xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW3xDilution.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW3xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOW3xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW3xDilution.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW3xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW3xDilution.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOW3xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOW3xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW3xDilution.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW3xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW3xDilution.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW3xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOW3xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW3xDilution.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW3xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW3xDilution.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW3xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOW5xDilution ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOW5xDilution-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOW5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW5xDilution.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW5xDilution.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW5xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOW5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW5xDilution.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW5xDilution.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW5xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOW5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW5xDilution.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW5xDilution.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOW5xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOW5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW5xDilution.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW5xDilution.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW5xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOW5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW5xDilution.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW5xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW5xDilution.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW5xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
#### plot - SLOW10xDilution ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/02_viewEXOfDOMtestdata_results/SLOW10xDilution-20251119.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOW10xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW10xDilution.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW10xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW10xDilution.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW10xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOW10xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW10xDilution.ts$ODO...local.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW10xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW10xDilution.ts$ODO...local.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW10xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Dissolved Oxygen (% sat)")

# temp
plot(ymd_hms(SLOW10xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW10xDilution.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW10xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW10xDilution.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOW10xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOW10xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW10xDilution.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW10xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW10xDilution.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW10xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOW10xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW10xDilution.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOW10xDilution.ts$datetimeMT, tz="US/Mountain"),(SLOW10xDilution.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOW10xDilution.ts$datetimeMT, breaks="1 min"),format="%H:%M", las=2)
title(main="Specific Conductance (us/cm)")

dev.off()
##################################################
#### summary values to compare to other tests ####

# To compare test data, it will be useful to have a summary number for each run
# This may be subject to change, but I will do the average of the last 5 values of each run

# make a vector of the run names to add to dataframe - change the names to suit what you did above!
runtype <- c(
  "20251119_SLOWintrinsic",
  "20251119_SLOWFe0.1ppm",
  "20251119_SLOWFe0.2ppm",
  "20251119_SLOWFe0.5ppm",
  "20251119_SLOWFe1ppm",
  "20251119_SLOWFe10ppm",
  "20251119_SLOWFe50ppm",
  "20251119_SLOWMn0.1ppm",
  "20251119_SLOWMn0.2ppm",
  "20251119_SLOWMn0.5ppm",
  "20251119_SLOWMn1ppm",
  "20251119_SLOWMn10ppm",
  "20251119_SLOWMn50ppm",
  "20251119_SLOW1.5xDilution",
  "20251119_SLOW2xDilution",
  "20251119_SLOW3xDilution",
  "20251119_SLOW5xDilution",
  "20251119_SLOW10xDilution"
  # repeat for however many
)

# average of turbidity
Mean.Turbidity.FNU.mn <- c(
  mean(tail(SLOWintrinsic.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWFe0.1ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWFe0.2ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWFe0.5ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWFe1ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWFe10ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWFe50ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWMn0.1ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWMn0.2ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWMn0.5ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWMn1ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWMn10ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWMn50ppm.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOW1.5xDilution.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOW2xDilution.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOW3xDilution.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOW5xDilution.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOW10xDilution.ts$Turbidity.FNU.mn),5)
  # repeat for however many
)

# average of DO
Mean.ODO...local.mn <- c(
  mean(tail(SLOWintrinsic.ts$ODO...local.mn),5),
  mean(tail(SLOWFe0.1ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWFe0.2ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWFe0.5ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWFe1ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWFe10ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWFe50ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWMn0.1ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWMn0.2ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWMn0.5ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWMn1ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWMn10ppm.ts$ODO...local.mn),5),
  mean(tail(SLOWMn50ppm.ts$ODO...local.mn),5),
  mean(tail(SLOW1.5xDilution.ts$ODO...local.mn),5),
  mean(tail(SLOW2xDilution.ts$ODO...local.mn),5),
  mean(tail(SLOW3xDilution.ts$ODO...local.mn),5),
  mean(tail(SLOW5xDilution.ts$ODO...local.mn),5),
  mean(tail(SLOW10xDilution.ts$ODO...local.mn),5)
  # repeat for however many
)

# average of temperature
Mean.Temp..C.mn <- c(
  mean(tail(SLOWintrinsic.ts$Temp..C.mn),5),
  mean(tail(SLOWFe0.1ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWFe0.2ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWFe0.5ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWFe1ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWFe10ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWFe50ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWMn0.1ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWMn0.2ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWMn0.5ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWMn1ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWMn10ppm.ts$Temp..C.mn),5),
  mean(tail(SLOWMn50ppm.ts$Temp..C.mn),5),
  mean(tail(SLOW1.5xDilution.ts$Temp..C.mn),5),
  mean(tail(SLOW2xDilution.ts$Temp..C.mn),5),
  mean(tail(SLOW3xDilution.ts$Temp..C.mn),5),
  mean(tail(SLOW5xDilution.ts$Temp..C.mn),5),
  mean(tail(SLOW10xDilution.ts$Temp..C.mn),5)
  # repeat for however many
)

# average of fDOM
Mean.fDOM.QSU.mn <- c(
  mean(tail(SLOWintrinsic.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWFe0.1ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWFe0.2ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWFe0.5ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWFe1ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWFe10ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWFe50ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWMn0.1ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWMn0.2ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWMn0.5ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWMn1ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWMn10ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWMn50ppm.ts$fDOM.QSU.mn),5),
  mean(tail(SLOW1.5xDilution.ts$fDOM.QSU.mn),5),
  mean(tail(SLOW2xDilution.ts$fDOM.QSU.mn),5),
  mean(tail(SLOW3xDilution.ts$fDOM.QSU.mn),5),
  mean(tail(SLOW5xDilution.ts$fDOM.QSU.mn),5),
  mean(tail(SLOW10xDilution.ts$fDOM.QSU.mn),5)
  # repeat for however many
)

# average of SpCond
Mean.SpCond.µS.cm.mn <- c(
  mean(tail(SLOWintrinsic.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWFe0.1ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWFe0.2ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWFe0.5ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWFe1ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWFe10ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWFe50ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWMn0.1ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWMn0.2ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWMn0.5ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWMn1ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWMn10ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWMn50ppm.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOW1.5xDilution.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOW2xDilution.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOW3xDilution.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOW5xDilution.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOW10xDilution.ts$SpCond.µS.cm.mn),5)
  # repeat for however many
)

averages <- data.frame(
  runtype,
  Mean.Turbidity.FNU.mn,
  Mean.ODO...local.mn,
  Mean.Temp..C.mn,
  Mean.fDOM.QSU.mn,
  Mean.SpCond.µS.cm.mn
)

view(averages)

###########################################
#### clean up before pushing to github ####

# save complied data
write.csv(SLOWintrinsic.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWintrinsic.ts.csv")
write.csv(SLOWFe0.1ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWFe0.1ppm.ts.csv")
write.csv(SLOWFe0.2ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWFe0.2ppm.ts.csv")
write.csv(SLOWFe0.5ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWFe0.5ppm.ts.csv")
write.csv(SLOWFe1ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWFe1ppm.ts.csv")
write.csv(SLOWFe10ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWFe10ppm.ts.csv")
write.csv(SLOWFe50ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWFe50ppm.ts.csv")
write.csv(SLOWMn0.1ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWMn0.1ppm.ts.csv")
write.csv(SLOWMn0.2ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWMn0.2ppm.ts.csv")
write.csv(SLOWMn0.5ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWMn0.5ppm.ts.csv")
write.csv(SLOWMn1ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWMn1ppm.ts.csv")
write.csv(SLOWMn10ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWMn10ppm.ts.csv")
write.csv(SLOWMn50ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWMn50ppm.ts.csv")
write.csv(SLOW1.5xDilution.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOW1.5xDilution.ts.csv")
write.csv(SLOW2xDilution.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOW2xDilution.ts.csv")
write.csv(SLOW3xDilution.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOW3xDilution.ts.csv")
write.csv(SLOW5xDilution.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOW5xDilution.ts.csv")
write.csv(SLOW10xDilution.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOW10xDilution.ts.csv")

write.csv(averages, "results/02_viewEXOfDOMtestdata_results/20251119.averages.csv")

# delete all raw google drive files
# get all files in the directories, recursively
f <- list.files("googledrive_data/", include.dirs = F, full.names = T, recursive = T)
# remove the files
file.remove(f)

# now commit your changes and and push them to github!!

