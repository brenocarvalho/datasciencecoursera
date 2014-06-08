source("getData.R")
#The code to read the dataset is in another file in this same folder
data <- getData()

plot2 <- function(X){
  #plot the graph
  timeStamp <- strptime(mapply(function(x,y) paste(x,y), data[,1], data[,2]), "%d/%m/%Y %H:%M:%S")
  png("plot2.png")
  plot(timeStamp, data$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
  dev.off()
}

plot2(data)