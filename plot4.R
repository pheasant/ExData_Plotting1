#Read Data
colnames = colnames(read.table("household_power_consumption.txt", nrow = 1, header = TRUE, sep=";"))
myData <- read.table(file = "household_power_consumption.txt", sep = ";", skip = 66637, col.names = colnames, nrows = 2880 )

myData[myData=="?"] <- NA #Convert "?" values to NAs 

#Convert strings to dates and time

myData[,1] <- as.Date(myData[,1], "%d/%m/%Y")
myData$date_time = paste(myData$Date, myData$Time, sep=" ")
myData$date_time1 <- strptime(myData[,10],format = "%Y-%m-%d %H:%M:%S" )

#Convert the rest of the factor variables into numeric

for (i in 3:9){
        myData[,i] <- as.numeric(as.character(myData[,i]))
}


#Getting the necessary data subset from 2007-02-01 and 2007-02-02

result <- subset(myData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02") )

#PLOT 4 
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
#PLOT 4.1
plot(result$date_time1, result$Global_active_power,  type="l", xlab = "", ylab = "Global Active Power (kw)")
#PLOT 4.2
plot(result$date_time1, result$Voltage,  type="l", xlab = "datetime", ylab = "Voltage")
#PLOT 4.3
plot(result$date_time1, result$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(result$date_time1, result$Sub_metering_2, col = "red")
lines(result$date_time1, result$Sub_metering_3, col = "blue")
legend( "topright", bty = "n", lty = c(1,1), cex=0.7, col = c("black","red", "blue" ), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) # Add a legend to the graph
#PLOT 4.4
plot(result$date_time1, result$Global_reactive_power,  type="l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()


