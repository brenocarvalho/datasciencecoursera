source("getData.R")
#The code to read the dataset is in another file in this same folder
data <- getData()

plot1 <- function(X){
  #plot the graph
  png("plot1.png")
  hist(data1$Global_active_power, xlab = "Global Active Power (kilowatts)", main="Global Active Power", col="red")
  dev.off()
}

plot1(data)