## Read the data and subset it using data.table package.
library(data.table)
DT <- fread("household_power_consumption.txt", na.strings="?")   
subDT <- DT[(DT$Date == "1/2/2007" | DT$Date == "2/2/2007"),]
rm(DT)

## Convert Global_active_power column to numeric, make the histogram and save it to png file.
png(file = "plot1.png.png")
subDT$Global_active_power <- as.numeric(subDT$Global_active_power)
hist(subDT$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()
