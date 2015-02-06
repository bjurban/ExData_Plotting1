library(data.table)
library(lubridate)

# Unzip Data
# unzip("exdata_data_household_power_consumption.zip")

# Read Data
power <- fread("household_power_consumption.txt", na.strings=c("?"))
# Note: na.strings ="?" does not work. This is a documented flaw in fread, see:
# http://r.789695.n4.nabble.com/fread-coercing-to-character-when-seeing-NA-td4677209.html 

# Subset Data to days of interest
psub <- subset(power, Date %in% c("1/2/2007", "2/2/2007"))

# Coerce Data to Numeric
psub$Global_active_power <- as.numeric(psub$Global_active_power)
psub$Global_reactive_power <- as.numeric(psub$Global_reactive_power)
psub$Sub_metering_1 <- as.numeric(psub$Sub_metering_1)
psub$Sub_metering_2 <- as.numeric(psub$Sub_metering_2)
psub$Sub_metering_3 <- as.numeric(psub$Sub_metering_3)
psub$Voltage <- as.numeric(psub$Voltage)

# Add timestamp column
psub$ts = dmy_hms(paste(psub$Date, psub$Time))

# Plot PNG file
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Plot 1
with(psub, 
     plot(ts, Global_active_power, col="black", type='l',
          xlab = "",
          ylab = "Global Active Power"))

# Plot 2
with(psub,
     plot(ts, Voltage, type='l', xlab="datetime"))

# Plot 3
plot(psub$ts, psub$Sub_metering_1, col="black", type='l',
     ylab="Energy sub metering",
     xlab="")
lines(psub$ts, psub$Sub_metering_2, col="red")
lines(psub$ts, psub$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, col=c("black","red","blue"), bty="n")

# Plot 4
with(psub, 
     plot(ts, Global_reactive_power, type='l', xlab="datetime"))

dev.off()
