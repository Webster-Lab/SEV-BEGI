#### read me ####

# the purpose of this script is to compile and plot EXO1 files from the SEV-BEGI project. 
# This script is specifically for working with test data sets (e.g., in lab and in field tests of batteries, monitoring protocols, etc.) 
# Another script will be created for working with "real" data sets that are part of our long-term time series for analysis and publication. These require combining multiple EXO files from multiple sondes, so the code is more sophisticated. This script is a good starting point to learning how to work with one file at a time. 

# NOTE: DO NOT push raw EXO1 files to the github repo! They are often too large for this. The purpose of the google drive workflow is to handle all these files, whereas github handles the scripts and condensed datasets :)
# The section below that "cleans up" the environment removes raw EXO files before pushing changes. 

#### libraries ####
library(googledrive)
library(tidyverse)
library(zoo)

#### load data from google drive ####

# Now is a good time to pull changes from GitHub :)

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

SLOWbattest = read.csv("googledrive_data/20250319_3230_SLOWbattest.csv", skip=9, header=T,
                       fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"

SLOCbattest = read.csv("googledrive_data/20250319_3231_SLOC_battest.csv", skip=9, header=T,
                       fileEncoding="utf-8") # this line makes it such that if there are any offending utf-16 encodings, it will show the offending file in the error message as "In readLines(file, skip) : invalid input found on input connection 'file name'"

#### format dates ####

### SLOWbattest
# put date and time in same column
SLOWbattest$datetime = paste(SLOWbattest$Date..MM.DD.YYYY.,  SLOWbattest$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOWbattest$datetimeMT = as.POSIXct( SLOWbattest$datetime, 
                                       format = "%m/%d/%Y %H:%M:%S",
                                       tz="US/Mountain")
# check that results are reasonable
summary(SLOWbattest$datetimeMT)
# NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
SLOWbattest = SLOWbattest[!is.na(SLOWbattest$datetimeMT),]

### SLOCbattest
# put date and time in same column
SLOCbattest$datetime = paste(SLOCbattest$Date..MM.DD.YYYY.,  SLOCbattest$Time..HH.mm.ss., sep = " ")
# convert to POIXct and set timezone
SLOCbattest$datetimeMT = as.POSIXct( SLOCbattest$datetime, 
                                     format = "%m/%d/%Y %H:%M:%S",
                                     tz="US/Mountain")
# check that results are reasonable
summary(SLOCbattest$datetimeMT)
# NAs are from the one hour of time lost to the daylight savings switch. It's easiest just to remove these rows
SLOCbattest = SLOCbattest[!is.na(SLOCbattest$datetimeMT),]


#### Compile bursts within 1 min ####

### SLOWbattest
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOWbattest)
SLOWbattest[5:19] = as.numeric(SLOWbattest[5:19])
# get means and standard deviations of numeric burst values
min<-round_date(SLOWbattest$datetimeMT, "minute") 
SLOWbattest.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm, fDOM.QSU, fDOM.RFU,
                                                             nLF.Cond.µS.cm,
                                                             ODO...sat,ODO...local,ODO.mg.L,
                                                             Sal.psu,SpCond.µS.cm,
                                                             TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                             Battery.V,Cable.Pwr.V) 
                                                       ~ min, SLOWbattest, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOWbattest.comp$datetimeMT<-as.POSIXct(SLOWbattest.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")

### SLOCbattest
# Make sure all columns with numeric data data are numeric. 
# Make sure columns you want numeric match the range indicated!
names(SLOCbattest)
SLOCbattest[5:22] = as.numeric(unlist(SLOCbattest[5:22])) # this sonde is recording vertical position and pressure, which is giving it two more columns. We need to make sure all the sondes are recording the same things in future!
# get means and standard deviations of numeric burst values. This is also a place where you can remove unwanted columns.
min<-round_date(SLOCbattest$datetimeMT, "minute") 
SLOCbattest.comp <- as.data.frame(as.list(aggregate(cbind(Cond.µS.cm, fDOM.QSU, fDOM.RFU,
                                                          nLF.Cond.µS.cm,
                                                          ODO...sat,ODO...local,ODO.mg.L,
                                                          Sal.psu,SpCond.µS.cm,
                                                          TDS.mg.L,Turbidity.FNU,TSS.mg.L,Temp..C,
                                                          Battery.V,Cable.Pwr.V) 
                                                    ~ min, SLOCbattest, na.action=na.pass, 
                                                    FUN=function(x) c(mn=mean(x), SD=sd(x)))))
SLOCbattest.comp$datetimeMT<-as.POSIXct(SLOCbattest.comp$min, "%Y-%m-%d %H:%M:%S", tz="US/Mountain")


#### complete timeseries with all possible time stamps ####

# this is a helpful step to assure that you have a row for every possible time point that should be in the data set. If there are any breaks in the data, this will allow them to be identified and potentially interpolated, and it will also prevent plotting errors and other issues that come up when working with time series. 

### SLOWbattest
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOWbattest.comp$datetimeMT),
    to = max(SLOWbattest.comp$datetimeMT),
    by = "15 min" ))
# make sure all time stamps in data set are rounded to nearest 15 min 
SLOWbattest.comp$datetimeMT<- lubridate::round_date(SLOWbattest.comp$datetimeMT, "15 minutes") 
# join to clean time stamps
SLOWbattest.ts = left_join(time, SLOWbattest.comp, by="datetimeMT")

### SLOCbattest
# create complete time series sequence using min/max of data set
time <- data.frame(
  datetimeMT = seq.POSIXt(
    from = min(SLOCbattest.comp$datetimeMT),
    to = max(SLOCbattest.comp$datetimeMT),
    by = "15 min" ))
# make sure all time stamps in data set are rounded to nearest 15 min 
SLOCbattest.comp$datetimeMT<- lubridate::round_date(SLOCbattest.comp$datetimeMT, "15 minutes") 
# join to clean time stamps
SLOCbattest.ts = left_join(time, SLOCbattest.comp, by="datetimeMT")

# check for duplicate time stamps
any(duplicated(SLOWbattest.comp$datetimeMT))
any(duplicated(SLOCbattest.comp$datetimeMT))


#### plot - SLOWbattest ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/01_viewEXOtestdata_results/SLOWbattest.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$ODO.mg.L.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="",ylim=c(-.5,.5))
lines(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$ODO.mg.L.mn),
      pch=20,col="black", xlab="", xaxt = "n",ylim=c(-.4,1), type="o")
axis.POSIXct(side=1,at=cut(SLOWbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="Dissolved Oxygen (mg/L)")

# temp
plot(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOWbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n",ylim=c(0,60), ylab="n")
lines(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n",ylim=c(-1,1300), type="n", ylab="")
lines(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="Specific Conductance (us/cm)")

# battery
plot(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$Battery.V.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOWbattest.ts$datetimeMT, tz="US/Mountain"),(SLOWbattest.ts$Battery.V.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOWbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="Battery (volts)")

dev.off()



#### plot - SLOCbattest ####

# Run the first 3 lines below and the dev.off() at the end along with the plotting code to save a multi-paneled plot as an image.
# or, run each code chunk individually to look at each data type by itself in the plotting panel.

# note that some plots have y-axes limits set to help view the data better. You should always view the plot without limits first, then set limits if it is helpful. 

jpeg("results/01_viewEXOtestdata_results/SLOCbattest.jpg", width = 12, height = 8, units="in", res=1000)
plot.new()
par(mfrow=c(3,2), mar=c(4,4,2,1.5))

# turbidity
plot(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$Turbidity.FNU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$Turbidity.FNU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOCbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="Turbidity (FNU)")

# DO
plot(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$ODO.mg.L.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="",ylim=c(-.5,0))
lines(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$ODO.mg.L.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOCbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="Dissolved Oxygen (mg/L)")

# temp
plot(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$Temp..C.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$Temp..C.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")#,ylim=c(22.5,24.5))
axis.POSIXct(side=1,at=cut(SLOCbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="Temperature (deg C)")

# fDOM
plot(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$fDOM.QSU.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n",ylim=c(0,60), ylab="n")
lines(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$fDOM.QSU.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOCbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="fDOM (QSU)")

# specific conductivity
plot(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$SpCond.µS.cm.mn),
     pch=20,col="black", xlab="", xaxt = "n",ylim=c(800,1300), type="n", ylab="")
lines(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$SpCond.µS.cm.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOCbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="Specific Conductance (us/cm)")

# battery
plot(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$Battery.V.mn),
     pch=20,col="black", xlab="", xaxt = "n", type="n", ylab="")
lines(ymd_hms(SLOCbattest.ts$datetimeMT, tz="US/Mountain"),(SLOCbattest.ts$Battery.V.mn),
      pch=20,col="black", xlab="", xaxt = "n", type="o")
axis.POSIXct(side=1,at=cut(SLOCbattest.ts$datetimeMT, breaks="24 hours"),format="%m-%d", las=2)
title(main="Battery (volts)")

dev.off()



#### clean up before pushing to github ####

# save complied data
write.csv(SLOWbattest.ts, "results/01_viewEXOtestdata_results/SLOWbattest.ts.csv")
write.csv(SLOCbattest.ts, "results/01_viewEXOtestdata_results/SLOCbattest.ts.csv")

# delete all raw google drive files
# get all files in the directories, recursively
f <- list.files("googledrive_data/", include.dirs = F, full.names = T, recursive = T)
# remove the files
file.remove(f)

# now commit your changes and and push them to github!!

