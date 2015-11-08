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
png(filename = "plot1.png", width = 480, height = 480)

# Build the histogram with the correct labels and color
hist(elect$Global_active_power, xlab = "Global Active Power (kilowatts)", col="red",main = "Global Active Power")

# -- Close the graphics device: the image is finished
dev.off()