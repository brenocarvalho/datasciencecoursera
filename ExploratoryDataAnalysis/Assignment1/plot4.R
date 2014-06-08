source("getData.R")
#The code to read the dataset is in another file in this same folder
data <- getData()

plot4 <- function(X){
  #plot the graph
  timeStamp <- strptime(mapply(function(x,y) paste(x,y), data[,1], data[,2]), "%d/%m/%Y %H:%M:%S")
  png("plot4.png")
  par(mfrow=c(2,2))
  plot(timeStamp, data$Global_active_power,xlab="", ylab="Global Active Power", type="l")
  plot(timeStamp, data$Voltage, xlab="datetime", ylab="Voltage", type="l")
  plot(timeStamp, data$Sub_metering_1, ylab="Energy sub metering", type="l")
  points(timeStamp, data$Sub_metering_1, col="black", type="l")
  points(timeStamp, data$Sub_metering_2, col="red",   type="l")
  points(timeStamp, data$Sub_metering_3, col="blue",  type="l")
  legend("topright", legend=c("Submetering_1", "Submetering_2", "Submetering_3"), col=c("black", "blue", "red"), lty=c(1,1))
  
  plot(timeStamp, data$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")
  dev.off()
}

plot4(data)