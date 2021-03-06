#a histogram of global active power for the days 2007-02-01 and
# 2007-02-02
plot1 <- function() {
	#set up data
	if (!file.exists("dat.zip")) {
		download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./dat.zip")
	}
	unzip("dat.zip")
	dat <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", quote = "\"", dec = ".", fill = TRUE, comment.char = "", 
	colClasses = c("character","character",rep("numeric",7)), na.strings="?",skip = 66637,nrows = 2880)
	#add the labels because row 1 was skipped
	names(dat) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
	#reformat date and time by combining the two and casting as a POSIXct object with associated formatting
	dat$DateTime <- as.POSIXct(paste(dat$Date,dat$Time),format = "%d/%m/%Y %H:%M:%S", tz = "EST")
	#set up graphical device
	png("plot1.png",width=480,height=480,units="px")
	#generate a histogram of global active power, add labels and ittle in one function call
	hist(dat$Global_active_power,xlab = "Global Active Power (kilowatts)",col="red",main="Global Active Power")
	dev.off()
	file.remove("household_power_consumption.txt")
}