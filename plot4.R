# Set the url for downloading the original zipped data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download to exdata_data_household_power_consumption.zip
download.file(url, dest="exdata_data_household_power_consumption.zip", method="curl")

# Unzip, producing household_power_consumption.txt
unzip("exdata_data_household_power_consumption.zip", overwrite = TRUE)

# Read the file to a data.frame, setting ? to NA
elect <- read.csv("household_power_consumption.txt", sep=";", na.strings = "?")

# Keep only the lines for the first 2 days of Feb/2007
elect <- subset(elect, Date %in% c("1/2/2007","2/2/2007"))

# Create a new column "DateTime", class POSIXlt from the original Date and Time columns
elect$DateTime <- strptime(with(elect, paste(Date, Time)), format = "%e/%m/%Y %H:%M:%S")

# -- Open the graphics device (png)
png(filename = "plot4.png", width = 480, height = 480)

# Set the grid for four graphs (2x2) by columns
par(mfcol = c(2,2))

# first graph is like plot2
plot (elect$DateTime, elect$Global_active_power, xlab= "", ylab = "Global Active Power", type = "n")
lines (elect$DateTime, elect$Global_active_power)

# second graph is like plot3
plot (elect$DateTime, elect$Sub_metering_1, xlab= "", ylab = "Energy sub metering", type = "n")
lines (elect$DateTime, elect$Sub_metering_1, col="black")
lines (elect$DateTime, elect$Sub_metering_2, col="red")
lines (elect$DateTime, elect$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1,1), bty="n")

# third graph is similar to plot2, but Voltage vs DateTime
plot (elect$DateTime, elect$Voltage, xlab="datetime", ylab = "Voltage", type = "n")
lines (elect$DateTime, elect$Voltage, col="black")

# fourth graph is Global_reactive_power vs DateTime
plot (elect$DateTime, elect$Global_reactive_power, xlab="datetime", ylab = "Global_reactive_power", type = "n")
lines (elect$DateTime, elect$Global_reactive_power, col="black")

# -- Close the graphics device: the image is finished
dev.off()