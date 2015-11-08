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
png("plot4.png")
## creates a 2 x 2 grid for subsequent plots
par(mfrow=c(2,2))
## Creates the first plot (which is the same as plot 2)
plot(powerdata$Time,powerdata$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Creates the second plot (top right)
plot(powerdata$Time, powerdata$Voltage, type="l", ylab="Voltage", xlab="datetime")

## Creates the third plot (bottom left) and populates it with the line of Sub_metering_1 to the open png in the default colour
plot(powerdata$Time,powerdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
## Adds the line plot of Sub_metering_2 to the third plot in the open png in red
points(powerdata$Time,powerdata$Sub_metering_2, type="l", col="red")
## Adds the line plot of Sub_metering_3 to the third plot in the open png in blue
points(powerdata$Time,powerdata$Sub_metering_3, type="l", col="blue")
## Adds the legend in the top right of the third plot
legend("topright", lty=c(1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Creates the fourth plot (bottom right)
plot(powerdata$Time, powerdata$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

## ends the stream of output to the png file, causing the result of the commands to be saved.
dev.off()