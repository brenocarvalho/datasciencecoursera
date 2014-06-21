#R code for assignment

setwd("~/Documents/git_repos/datasciencecoursera/ExploratoryDataAnalysis/Assignment2")
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")



#plot1
png("plot1.png")
EmissionsByYear <- aggregate(Emissions ~ year, NEI[,c("year", "Emissions")], sum)
plot(EmissionsByYear, type="l", main="Overal Emissions")
dev.off()

#plot2
png("plot2.png")
EmissionsBaltimoreByYear <- aggregate(Emissions ~ year, NEI[NEI$fips == "24510",c("year", "Emissions")], sum)
plot(EmissionsBaltimoreByYear, type="l", main="Emissions in Baltimore")
dev.off()

#plot3
png("plot3.png")
EmissionsByYearAndType   <- aggregate(Emissions ~ year + type + fips, NEI, sum)
EmissionsByYearAndTypeInBaltimore <- EmissionsByYearAndType[EmissionsByYearAndType$fips == "24510",]

ggplot(EmissionsByYearAndTypeInBaltimore, aes(x = EmissionsByYearAndTypeInBaltimore$year, y= EmissionsByYearAndTypeInBaltimore$Emissions))+
  geom_line(aes(colour = EmissionsByYearAndTypeInBaltimore$type))+
  scale_colour_discrete(name="Type")+
  ggtitle("Emissions in Baltimore")+
  xlab("Years")+ylab("Emission")

dev.off()

#plot4
png("plot4.png")
RelevantSCC <- SCC[(SCC$EI.Sector == "Fuel Comb - Electric Generation - Coal") |
                   (SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal")  |
                   (SCC$EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal"), "SCC"]
CoalEmissions <- aggregate(Emissions ~ year, subset(NEI, SCC %in% RelevantSCC), sum)
plot(CoalEmissions, type="l", main="Emissions from coal combustion-related sources")

dev.off()

#plot5
png("plot5.png")
RelevantSCC <- SCC[(SCC$EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles") |
                   (SCC$EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles") |
                   (SCC$EI.Sector == "Mobile - Locomotives") |
                   (SCC$EI.Sector == "Mobile - Aircraft") |
                   (SCC$EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles") |
                   (SCC$EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles") |
                   (SCC$EI.Sector == "Mobile - Non-Road Equipment - Gasoline"), "SCC"]
VehicleEmission <- aggregate(Emissions ~ year, subset(NEI[NEI$fips == "24510",], SCC %in% RelevantSCC), sum)
plot(VehicleEmission, type="l", main="Emissions from motor vehicle sources in Baltimore")

dev.off()

#plot6
png("plot6.png")
RelevantSCC <- SCC[(SCC$EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles") |
                     (SCC$EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles") |
                     (SCC$EI.Sector == "Mobile - Locomotives") |
                     (SCC$EI.Sector == "Mobile - Aircraft") |
                     (SCC$EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles") |
                     (SCC$EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles") |
                     (SCC$EI.Sector == "Mobile - Non-Road Equipment - Gasoline"), "SCC"]
VehicleEmission <- aggregate(Emissions ~ year+fips, subset(NEI[NEI$fips == "24510" | NEI$fips == "06037",], SCC %in% RelevantSCC), sum)
fips <- sapply(VehicleEmission$fips, function(x){ if (x == "24510"){"Baltimore City"} else{"Los Angeles County"}})
VehicleEmission$fips <- fips
ggplot(VehicleEmission, aes(x=VehicleEmission$year, y=VehicleEmission$Emissions))+
  geom_line(aes(colour=VehicleEmission$fips))+
  scale_colour_discrete(name="Type")+
  ggtitle("Emissions from motor vehicle sources")+
  xlab("Years")+ylab("Emission")
dev.off()