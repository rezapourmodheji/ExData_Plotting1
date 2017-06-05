rm(list=ls())
cat("\014")
library(dplyr)
## ------------------------Reading Data-----------------------------
rawdata <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",stringsAsFactors=FALSE)
## ------------------------Preparing Data---------------------------
rawdata$Date <- as.Date(strptime(rawdata$Date,"%d/%m/%Y")) 
first <- as.Date("2007-02-01")
datedata <- filter( rawdata , Date == first | Date == (first+1) )
## ------------------------Ploting Data---------------------------
png(file = "plot1.png", width = 480, height = 480, units = "px")
GAP <- datedata$Global_active_power[ datedata$Global_active_power != "?" ]
GAP <- as.numeric( GAP )
hist(GAP , col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()