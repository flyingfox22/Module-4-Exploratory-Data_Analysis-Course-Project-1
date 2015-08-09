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

## Plot 2
plot(data2$Global_active_power~data2$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()



