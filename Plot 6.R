#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
#has seen greater changes over time in motor vehicle emissions?

#Download the data
if(!file.exists("Emissions Data.zip")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileUrl, "Emissions Data.zip", method = "curl")
        unzip("Emissions Data.zip")
}

#Read the data into R
if(!exists("NEI")){
        NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
        SCC <- readRDS("Source_Classification_Code.rds")
}

#Merge the datasets
if(!exists("Merged_NEI_SCC")){
        Merged_NEI_SCC <- merge(NEI, SCC, by="SCC")
}

#Subset the motor vehicle data
if(!exists("logical_vehicle_vector")){
        logical_vehicle_vector <- grepl("vehicle", Merged_NEI_SCC$Short.Name, ignore.case=TRUE)
}

if(!exists("motor_vehicle_data")){
        motor_vehicle_data <- Merged_NEI_SCC[logical_vehicle_vector, ]
}

#Subset the combine the Baltimore and Los Angeles motor vehicle data
Baltimore_motor_vehicle_data <- motor_vehicle_data[motor_vehicle_data$fips=="24510",]

LA_motor_vehicle_data <- motor_vehicle_data[motor_vehicle_data$fips=="06037",]

Bmore_LA_motor_vehicle_data <- rbind(Baltimore_motor_vehicle_data, LA_motor_vehicle_data)

#Rename the fips column to city
Bmore_LA_motor_vehicle_data$fips[Bmore_LA_motor_vehicle_data$fips == "24510"] <- "Baltimore"

Bmore_LA_motor_vehicle_data$fips[Bmore_LA_motor_vehicle_data$fips == "06037"] <- "Los Angeles"

names(Bmore_LA_motor_vehicle_data)[names(Bmore_LA_motor_vehicle_data)=="fips"] <- "city"

# Make a plot showing emissions from motor vehicles in Baltimore and Los Angeles
Vehicle_Related_Emissions <- aggregate(Emissions ~ year + city, Bmore_LA_motor_vehicle_data, sum)

png("Plot 6.png")
x <- qplot(year, 
           Emissions, 
           data = Vehicle_Related_Emissions, 
           color = city, 
           geom = "line",
           xlab = "Year", 
           ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
           main = expression("Baltimore vs. Los Angeles" ~ PM[2.5] ~ "Emissions by Year"))
print(x)
dev.off()