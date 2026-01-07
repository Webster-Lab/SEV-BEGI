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
# library(dplyr) # actually don't think I need this

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



#### Compile bursts within 1 min ####

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
  "20251119_SLOWFe50ppm"
  # repeat for however many
)

# average of turbidity
Mean.Turbidity.FNU.mn <- c(
  mean(tail(SLOWintrinsic.ts$Turbidity.FNU.mn),5),
  mean(tail(SLOWFe0.1ppm.ts$Turbidity.FNU.mn),5),
  # repeat for however many
)

# average of DO
Mean.ODO...local.mn <- c(
  mean(tail(SLOWintrinsic.ts$ODO...local.mn),5),
  mean(tail(SLOWFe0.1ppm.ts$ODO...local.mn),5),
  # repeat for however many
)

# average of temperature
Mean.Temp..C.mn <- c(
  mean(tail(SLOWintrinsic.ts$Temp..C.mn),5),
  mean(tail(SLOWFe0.1ppm.ts$Temp..C.mn),5),
  # repeat for however many
)

# average of fDOM
Mean.fDOM.QSU.mn <- c(
  mean(tail(SLOWintrinsic.ts$fDOM.QSU.mn),5),
  mean(tail(SLOWFe0.1ppm.ts$fDOM.QSU.mn),5),
  # repeat for however many
)

# average of SpCond
Mean.SpCond.µS.cm.mn <- c(
  mean(tail(SLOWintrinsic.ts$SpCond.µS.cm.mn),5),
  mean(tail(SLOWFe0.1ppm.ts$SpCond.µS.cm.mn),5),
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


#### clean up before pushing to github ####

# save complied data
write.csv(SLOWintrinsic.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWintrinsic.ts.csv")
write.csv(SLOWFe0.1ppm.ts, "results/02_viewEXOfDOMtestdata_results/20251119.SLOWFe0.1ppm.ts.csv")

write.csv(averages, "results/02_viewEXOfDOMtestdata_results/20251119.averages.csv")

# delete all raw google drive files
# get all files in the directories, recursively
f <- list.files("googledrive_data/", include.dirs = F, full.names = T, recursive = T)
# remove the files
file.remove(f)

# now commit your changes and and push them to github!!

