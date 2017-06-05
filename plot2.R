rm(list=ls())
cat("\014")
library(dplyr)
## ------------------------Reading Data-----------------------------
rawdata <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",stringsAsFactors=FALSE)
## ------------------------Preparing Data---------------------------
rawdataf <- rawdata %>% mutate( Time = paste(Date,Time))
rawdataf$Time <- (strptime(rawdataf$Time,"%d/%m/%Y %H:%M:%S")) 
rawdataf <- select(rawdataf,-Date)
first <- as.Date("2007-02-01")
datedata <- subset(rawdataf,as.Date((Time)) == (first) | as.Date((Time)) == (first+1)  )
GAP <- datedata$Global_active_power[ datedata$Global_active_power != "?" ]
GAP <- as.numeric( GAP )
## ------------------------Ploting Data---------------------------
png(file = "plot2.png", width = 480, height = 480, units = "px")
with( datedata,plot(Time,GAP,type="l",ylab = "Global Active Power (kilowatts)", xlab = "") )
dev.off()