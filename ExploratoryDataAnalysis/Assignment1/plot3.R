source("getData.R")
#The code to read the dataset is in another file in this same folder
data <- getData()

plot3 <- function(X){
  #plot the graph
  timeStamp <- strptime(mapply(function(x,y) paste(x,y), data[,1], data[,2]), "%d/%m/%Y %H:%M:%S")
  png("plot3.png")
    plot(timeStamp, data$Sub_metering_1, xlab="", ylab="Global Active Power", type="l")
    points(timeStamp, data$Sub_metering_1, col="black", type="l")
    points(timeStamp, data$Sub_metering_2, col="red",   type="l")
    points(timeStamp, data$Sub_metering_3, col="blue",  type="l")
    legend("topright", legend=c("Submetering_1", "Submetering_2", "Submetering_3"), col=c("black", "blue", "red"), lty=c(1,1))
  dev.off()
}

plot3(data)