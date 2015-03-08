## Read the data and subset it using data.table package.
library(data.table)
DT <- fread("household_power_consumption.txt", na.strings="?")
subDT <- DT[(DT$Date == "1/2/2007" | DT$Date == "2/2/2007"),]
rm(DT)

## Convert Date column to Date class, add the datetime column, which combines Date and Time,
## to the subset of the data. Also convert Global_active_power to numeric. 
subDT$Date <- as.Date(subDT$Date, "%e/%m/%Y")
datetime <- strptime(paste(subDT$Date, subDT$Time, sep = " "), format = "%F %H:%M:%S")
subDT <- cbind(subDT, datetime)
subDT$Global_active_power <- as.numeric(subDT$Global_active_power)

## Make the plot and save it to png file.
png(file = "plot2.png.png")
with(subDT, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = ""))
title(ylab = "Global Active Power (kilowatts)")
dev.off()
