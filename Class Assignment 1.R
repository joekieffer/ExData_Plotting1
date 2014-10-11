library(lubridate)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power_data",method="curl")
unzip("power_data")
vars <- read.table("household_power_consumption.txt", sep =";" , header = TRUE, na.strings=c("?",""))
vars <- vars[complete.cases(vars),]
vars$Date <- dmy(vars$Date)
get.date <- vars$Date <= "2007-02-02" & vars$Date > "2007-01-31"
data <- vars[get.date,]

#Plot 1
png(file="plot1.png", bg="transparent")
hist(as.numeric(as.character(data$Global_active_power)),xlab="Global Active Power (kilowatts)", main="Global Active Power",col="red")
dev.off()

#Plot 2
png(file="plo2.png", bg="transparent")
plot(as.POSIXct(paste(data$Date, data$Time)),data$Global_active_power, type="l",xlab="",ylab="Global active power (kilowatts)")
dev.off()

#plot 3
png(file="plot3.png", bg="transparent")
with(data,{
    plot(as.POSIXct(paste(data$Date, data$Time)),data$Sub_metering_1, type="l", col="black",xlab="",ylab="Energy sub metering")
    lines(as.POSIXct(paste(data$Date, data$Time)),data$Sub_metering_2, type="l", col="red")
    lines(as.POSIXct(paste(data$Date, data$Time)),data$Sub_metering_3, type="l", col="blue")
    legend("topright",lwd="1", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})
dev.off()

#plot 4
png(file="plot4.png", bg="transparent")
par(mfrow=c(2,2))
plot(as.POSIXct(paste(data$Date, data$Time)),data$Global_active_power, type="l",xlab="",ylab="Global Active Power")
plot(as.POSIXct(paste(data$Date, data$Time)),data$Voltage, type="l",xlab="datetime",ylab="Voltage")
with(data,{
    plot(as.POSIXct(paste(data$Date, data$Time)),data$Sub_metering_1, type="l", col="black",xlab="",ylab="Energy sub metering")
    lines(as.POSIXct(paste(data$Date, data$Time)),data$Sub_metering_2, type="l", col="red")
    lines(as.POSIXct(paste(data$Date, data$Time)),data$Sub_metering_3, type="l", col="blue")
    legend("topright",lwd="1", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
})
plot(as.POSIXct(paste(data$Date, data$Time)),data$Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()