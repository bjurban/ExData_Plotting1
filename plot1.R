library(data.table)

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

# Plot PNG file
png("plot1.png", width=480, height=480)
with(psub, 
     hist(Global_active_power, col="red", 
          xlab="Global Active Power (kilowatts)",
          main="Global Active Power"))
dev.off()
