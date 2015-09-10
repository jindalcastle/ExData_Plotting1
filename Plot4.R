## Reading the data and subsetting to only the time we want to analyze. 
data <- read.table("household_power_consumption.txt", sep=";", header = T, colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'), na.strings = "?")
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data <- subset(data, as.Date(DateTime) >= as.Date("2007-02-01") & as.Date(DateTime) <= as.Date("2007-02-02"))

## Creating the PNG requirements and plotting the Global Active Power data, voltage, sub metering, and Global Reative Power
png("plot4.png", height = 480, width = 480)

par(mfcol = c(2,2))

## plot for the global active power
plot(data$DateTime, data$Global_active_power, pch = NA, xlab = "", ylab = "Global Active Power (kilowatts)")

lines(data$DateTime, data$Global_active_power)

##plot for the sub metering

plot(data$DateTime, data$Sub_metering_1, pch = NA, xlab = "", ylab = "Energy Sub metering")

lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))

## plot for the voltage
plot(data$DateTime, data$Voltage, ylab = "Voltage", xlab = "datetime", pch = NA)
lines(data$DateTime, data$Voltage)

## plot for the global reactive power
with(data, plot(DateTime, Global_reactive_power, xlab = "datetime", pch = NA))
with(data, lines(DateTime, Global_reactive_power))

dev.off()
