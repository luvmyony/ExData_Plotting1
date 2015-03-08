## Read the data and subset it using data.table package.
library(data.table)
DT <- fread("household_power_consumption.txt", na.strings="?")
subDT <- DT[(DT$Date == "1/2/2007" | DT$Date == "2/2/2007"),]
rm(DT)

## Convert Date column to Date class, add the datetime column, which combines Date and Time,
## to the subset of the data. Also convert columns to be used as y coordinates in the plots to numeric.
subDT$Date <- as.Date(subDT$Date, "%e/%m/%Y")
datetime <- strptime(paste(subDT$Date, subDT$Time, sep = " "), format = "%F %H:%M:%S")
subDT <- cbind(subDT, datetime)
subDT$Global_active_power <- as.numeric(subDT$Global_active_power)
subDT$Voltage <- as.numeric(subDT$Voltage)
subDT$Sub_metering_1 <- as.numeric(subDT$Sub_metering_1)
subDT$Sub_metering_2 <- as.numeric(subDT$Sub_metering_2)
# Sub_metering_3 is already in numeric.
subDT$Global_reactive_power <- as.numeric(subDT$Global_reactive_power)

## Make the plots and save them to png file.
png(file = "plot4.png.png")
par(mfrow = c(2,2))
with(subDT, {
        plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        plot(datetime, Voltage, type = "l")
        {
        plot(datetime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
        lines(datetime, Sub_metering_2, col = "red")
        lines(datetime, Sub_metering_3, col = "blue")
        legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        }
        plot(datetime, Global_reactive_power, type = "l")
})
dev.off()