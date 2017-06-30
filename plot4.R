## This assigment is part of coursera's "Data Science: Exploratory Data Analysis" module
## Week 1 assignment
## Description: This file loads "Electric Power Consumption" data from 
## "household_power_consumption.txt" file and plots a X-Y line chart of 
## "Energy Submetering" frequencies between the
## dates "2007-02-01" and "2007-02-02" excluding "?" missing values

## R File Name: "plot4.R"
## Input File Name: "household_power_consumption.txt"
## Ouput File Name: "plot4.png"

## Date of submission of assigment: 01-July-2017
## GitHub User Name: coolfox0407
## Email ID: coolfox.hari@gmail.com
## Name: Hariharan D

## Read the dataset

dataSetFull <- read.table("./data/household_power_consumption.txt", header=TRUE, sep = ";", na.strings = "?", nrows= 1000000, stringsAsFactors = FALSE)

## Create a new variable "DateTime" to store Date and Time in a single column

dataSetFull$DateTime <- paste(dataSetFull$Date, dataSetFull$Time)

## Format the new variable "DateTime" to Date format

dataSetFull$DateTime <- as.Date(dataSetFull$DateTime, format = "%d/%m/%Y %H:%M:%S")

## Filter/Subset the data to contain the data only for
   ## date time greater than equal to "2007-02-01 00:00:00" and less than
      ## "2007-02-03 00:00:00"

subSetData <- filter(dataSetFull, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))

## Convert the Date and Time data from "Character" format to "POSIXlt" format

subSetData$DT <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## Explicitly launch a file based graphic device - Bitmap format ".png" with width and height equals 480

png("plot4.png", width=480, height=480)

## Create a multi-pannel plotting window using "par" and "mfrow"

par(mfrow = c(2, 2), mar = c(4,4,2,1), oma = c(0,0,2,0)) 

## Plot a X-Y line chart from Base Plotting system with appropriate labelling for plot area (1, 1)

plot(subSetData$DT, subSetData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", cex=0.2)

## Plot a X-Y line chart from Base Plotting system with appropriate labelling for plot area (1, 2)

plot(subSetData$DT, subSetData$Voltage, type="l", xlab="datetime", ylab="Voltage (volt)")

## Plot a X-Y line chart from Base Plotting system with appropriate labelling for plot area (2, 1)
## Annotate the X-Y line chart as per the requirements and add legend

plot(subSetData$DT, subSetData$Sub_metering_1, type="l", xlab="", ylab="Energy Submetering (watt-hr of actv energy)")
lines(subSetData$DT, subSetData$Sub_metering_2, type="l", col="red")
lines(subSetData$DT, subSetData$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

## Plot a X-Y line chart from Base Plotting system with appropriate labelling for plot area (2, 2)

plot(subSetData$DT, subSetData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power (kilowatts)")

## Explicitly close the graphics device

dev.off()
