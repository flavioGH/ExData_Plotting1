# plot1.R
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
## PLOT1
##

png("plot1.png", width=480, height=480)

## Plot 1
hist(powerdat[, Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()

