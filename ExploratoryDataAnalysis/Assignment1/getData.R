getData <- function(x){
  #Read file
  data_set_path = "/Users/brenowcarvalho/Documents/Coursera/DataScience/Exploratory Data Analysis"
  
  full_data = read.csv(paste(data_set_path,"household_power_consumption.txt", sep = "/"),
                       sep = ";", na.strings="?",
                       colClasses=c("character","character", rep("numeric",7)),
                       col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power","Voltage",
                                     "Global_intensity", "Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  dates <- sapply(full_data[,1], function(x) as.Date(x, format="%d/%m/%Y"))
  class(dates) <-"Date"
  minDate <- as.Date("2007-02-01")
  maxDate <- as.Date("2007-02-02")
  #subset the data
  data <- full_data[(minDate <= dates) & (dates <= maxDate),]
  
  data
}
