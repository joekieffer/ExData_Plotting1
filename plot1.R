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

#Building plot 1
png(file="plot1.png", bg="transparent")
hist(as.numeric(as.character(data$Global_active_power)),xlab="Global Active Power (kilowatts)", main="Global Active Power",col="red")
dev.off()