library(lubridate)
## extract files from internet and then unzip files into a local directory
if (!dir.exists("data")){
        dir.create("data")
}
if (!file.exists("./data/ExData_Plotting1-master.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./data/data.zip")
} 

if (!file.exists("./data/data")){
        unzip("./data/data.zip", exdir = "./data")
} else {
        return("unzipped file already exists")
}

##subset values from 2007-02-01 to 2007-02-02
all_data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", skip = 66636, nrows = 2880, stringsAsFactors = FALSE)
names(all_data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
all_data$DateTime <- paste(all_data$Date, all_data$Time)
all_data$DateTime <- dmy_hms(all_data$DateTime)

##change parameters, making plot an array of four graphs
par(mfrow = c(2,2))

##populate plots
with(all_data, plot(all_data$DateTime, all_data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(all_data, plot(all_data$DateTime, all_data$Voltage, ylab = "Voltage", xlab = "datetime", type = "l"))
with(all_data, plot(all_data$DateTime, all_data$Sub_metering_1, type = "n", xlab="", ylab = "Energy sub metering"))
lines(all_data$DateTime, all_data$Sub_metering_1, col = "black")
lines(all_data$DateTime, all_data$Sub_metering_2, col = "red")
lines(all_data$DateTime, all_data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.6, bty= "n")
with(all_data, plot(all_data$DateTime, all_data$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l"))

