# Please note that I am Portuguese and the weekday names in Portuguese are Qui = Thr; Sex = Fri; Sáb = Sat

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
png(filename = "plot3.png", width = 480, height = 480)

# Create an empty labeled graph
plot (elect$DateTime, elect$Sub_metering_1, xlab= "", ylab = "Energy sub metering", type = "n")
# draw the lines connecting Sub_metering_1 in black
lines (elect$DateTime, elect$Sub_metering_1, col="black")
# draw the lines connecting Sub_metering_2 in red
lines (elect$DateTime, elect$Sub_metering_2, col="red")
# draw the lines connecting Sub_metering_3 in blue
lines (elect$DateTime, elect$Sub_metering_3, col="blue")
# set the legend with the correct labels, colors and lines
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1,1))

# -- Close the graphics device: the image is finished
dev.off()