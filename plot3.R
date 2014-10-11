#Library calls
library(lubridate)

#downloading the data file to the working directory ad power_data.zip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power_data",method="curl")
unzip("power_data")

#readinf the whole faile after calculation my computer could handel the whole file being open
vars <- read.table("household_power_consumption.txt", sep =";" , header = TRUE, na.strings=c("?",""))
#stripping out the NA rows
vars <- vars[complete.cases(vars),]
#converting time to posix
vars$Date <- dmy(vars$Date)
#filtering data to specified date ranges
get.date <- vars$Date <= "2007-02-02" & vars$Date > "2007-01-31"
data <- vars[get.date,]

#building plot 3
png(file="plot3.png", bg="transparent")
with(data,{
    plot(as.POSIXct(paste(data$Date, data$Time)),data$Sub_metering_1, type="l", col="black",xlab="",ylab="Energy sub metering")
    lines(as.POSIXct(paste(data$Date, data$Time)),data$Sub_metering_2, type="l", col="red")
    lines(as.POSIXct(paste(data$Date, data$Time)),data$Sub_metering_3, type="l", col="blue")
    legend("topright",lwd="1", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})
dev.off()
