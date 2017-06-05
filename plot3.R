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
SM1 <- datedata$Sub_metering_1 [ datedata$Sub_metering_1 != "?" ]
SM2 <- datedata$Sub_metering_2 [ datedata$Sub_metering_2 != "?" ]
SM3 <- datedata$Sub_metering_3 [ datedata$Sub_metering_3 != "?" ]
SM1 <- as.numeric( SM1 )
SM2 <- as.numeric( SM2 )
SM3 <- as.numeric( SM3 )
## ------------------------Ploting Data---------------------------
png(file = "plot3.png", width = 480, height = 480, units = "px")
plot( datedata$Time , SM1 , type="l" , ylab = "Energy sub metering", xlab = "" , col = "black")
lines( datedata$Time , SM2 , col = "red" )
lines( datedata$Time , SM3 , col = "blue" )
legends <- c ("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",legend=legends,lty=c(1,1,1),col = c("black","red","blue"))
dev.off()