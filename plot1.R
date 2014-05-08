#Read Data
myData <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";" )

myData[myData=="?"] <- NA #Convert "?" values to NAs 

#Convert strings to dates and time

myData[,1] <- as.Date(myData[,1], "%d/%m/%Y")
myData$date_time = paste(myData$Date, myData$Time, sep=" ")
myData$date_time1 <- strptime(myData[,10],format = "%Y-%m-%d %H:%M:%S" )

#Convert the rest of the factor variables into numeric

# **** as.numeric applied to a factor is meaningless, and may happen by implicit coercion. 
# To transform a factor f to approximately its original numeric values, as.numeric(levels(f))[f] 
# is recommended and slightly more efficient than  as.numeric(as.character(f)).


for (i in 3:9){
        myData[,i] <- as.numeric(as.character(myData[,i]))
}


#Getting the necessary data subset from 2007-02-01 and 2007-02-02

result <- subset(myData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02") )

#PLOT 1
png("plot1.png", width = 480, height = 480)

hist(result$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kw)")
dev.off()