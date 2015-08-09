## Getting full dataset
fileDir <- "exdata-data-household_power_consumption\\"
fileName <- "household_power_consumption.txt"
filePath<-paste(fileDir,fileName,sep = "")

## The dataset has 2,075,259 rows and 9 columns.
data <- read.table(filePath, header = T, sep = ";",na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"' )
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Only be using data from the dates 2007-02-01 and 2007-02-02
data2 <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)

## Converting dates
datetime <- paste(as.Date(data2$Date), data2$Time)
data2$Datetime <- as.POSIXct(datetime)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data2, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()