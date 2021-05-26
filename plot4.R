# plot4.R
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
## PLOT4
##


png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(powerdat[, datetime], powerdat[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(powerdat[, datetime],powerdat[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(powerdat[, datetime], powerdat[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerdat[, datetime], powerdat[, Sub_metering_2], col="red")
lines(powerdat[, datetime], powerdat[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue") , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ") , lty=c(1,1) , bty="n" , cex=.5) 

# Plot 4
plot(powerdat[, datetime], powerdat[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

