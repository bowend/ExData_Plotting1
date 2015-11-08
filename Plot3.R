## This line assumes that the user's working directory already contains the dataset, with its original name.
## It reads the data in, using the correct separator and NA character for the data set
## It also coerces all of the data to their correct data types in R, except the date and time collumns, which remain character data) .
powercons <- read.csv("household_power_consumption.txt", sep=";", na.strings = c("?"), colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
## Converts the Data column to the R Date type.
powercons[,1] <- as.Date(powercons[,1], format="%d/%m/%Y")
## Extracts the subset of data that we are interested in for this project (the 1st and second days of February in 2007)
powerdata <- powercons[powercons[,1] == as.Date("2007-02-01") | powercons[,1] == as.Date("2007-02-02"),]

## For this plot need to display the data over time, so (for the subset only) we will conver the time data
## Not strictly necessary, but we'll include the actual date (as opposed to allowing the date component to default to today)
## Also set usetz to blank, because the time zone is not known
powerdata$Time <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), format = "%Y-%m-%d %H:%M:%S")

##Call to the png function opens a png file to write out plot to.
##480x480 pixcels is the default size for a png created using the png function, so these are not specified
png("plot3.png")

## Adds the line plot of Sub_metering_1 to the open png in the default colour
plot(powerdata$Time,powerdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
## Adds the line plot of Sub_metering_2 to the open in png in red
plot(powerdata$Time,powerdata$Sub_metering_2, type="l", col="red")
## Adds the line plot of Sub_metering_3 to the open in png in blue
plot(powerdata$Time,powerdata$Sub_metering_2, type="l", col="blue")

## ends the stream of output to the png file, causing the result of the commands to be saved.
dev.off()