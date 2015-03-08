## Read the data and subset it using data.table package.
library(data.table)
DT <- fread("household_power_consumption.txt", na.strings="?")
subDT <- DT[(DT$Date == "1/2/2007" | DT$Date == "2/2/2007"),]
rm(DT)

## Convert Date column to Date class, add the datetime column, which combines Date and Time,
## to the subset of the data. Also convert columns to be used as y coordinates in the plot to numeric.
subDT$Date <- as.Date(subDT$Date, "%e/%m/%Y")
datetime <- strptime(paste(subDT$Date, subDT$Time, sep = " "), format = "%F %H:%M:%S")
subDT <- cbind(subDT, datetime)
subDT$Sub_metering_1 <- as.numeric(subDT$Sub_metering_1)
subDT$Sub_metering_2 <- as.numeric(subDT$Sub_metering_2)
# Sub_metering_3 is already in numeric.

## Make the plot and save it to png file.
png(file = "plot3.png.png")
with(subDT, plot(datetime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = ""))
with(subDT, lines(datetime, Sub_metering_2, col = "red"))
with(subDT, lines(datetime, Sub_metering_3, col = "blue"))
title(ylab = "Energy sub metering")
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()