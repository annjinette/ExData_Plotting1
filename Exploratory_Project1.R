#EXPLORATORY DATA ANALYSIS - PROJECT 1

##set working directory; create data folder if non exists
setwd("/Users/ann.hess/Desktop/files")
getwd()
list.files(getwd())

if(!file.exists("data")) {
  dir.create("data")
}

#read data
data_full <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?",
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
#format dates
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")
#subset data 
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)
## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
#generate plots
library(ggplot2)
library(lattice)
#Plot Notes:
##base graphics - piecemeal construction
##lattice graphics - created with a single function
##ggplot2 - combines concepts but uses independent implimentation
##?par -- parameters that can be tweaked in base

#plot1 - histogram
hist(data1$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)",col="red")
dev.copy(png,file="plot1.png", height=480, width=480)
dev.off()

## Plot 2 - simple line
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,file="plot2.png", height=480, width=480)
dev.off()

#Plot 3 - multiple lines
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,file="plot3.png", height=480, width=480)
dev.off()

#Plot 4 - multiple line graphs by Day of Week
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l",
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l",
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png,file="plot4.png", height=480, width=480)
dev.off()






