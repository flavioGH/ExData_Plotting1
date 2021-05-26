# plot3.R
##
## COMMONS
##
library("data.table")

#Reads  from file
powerdat <- data.table::fread(input = "household_power_consumption.txt" , na.strings="?")

# Change scientific notation
powerdat[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Add Datetime
powerdat[, datetime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
# Change Date to Date Type
powerdat[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
# Valid Interval 2007-02-01 and 2007-02-02
powerdat <- powerdat[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

##
## PLOT3
##

png("plot3.png", width=480, height=480)

# Plot 3
plot(powerdat[, datetime], powerdat[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerdat[, datetime], powerdat[, Sub_metering_2],col="red")
lines(powerdat[, datetime], powerdat[, Sub_metering_3],col="blue")
legend("topright" , col=c("black","red","blue") , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ") ,lty=c(1,1), lwd=c(1,1))

dev.off()

