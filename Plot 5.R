#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

#Subset the Motor Vehicle Data for Baltimore
if(!exists("logical_vehicle_vector")){
        logical_vehicle_vector <- grepl("vehicle", Merged_NEI_SCC$Short.Name, ignore.case=TRUE)
}

if(!exists("motor_vehicle_data")){
        motor_vehicle_data <- Merged_NEI_SCC[logical_vehicle_vector, ]
}

Baltimore_motor_vehicle_data <- motor_vehicle_data[motor_vehicle_data$fips=="24510",]

# Make a plot showing emissions from motor vehicles in Baltimore
Vehicle_Related_Emissions <- aggregate(Emissions ~ year, Baltimore_motor_vehicle_data, sum)

png("Plot 5.png")
plot(Vehicle_Related_Emissions, 
     type = "l",
     xlab = "Year", 
     ylab = expression("Motor Vehicle" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total Baltimore Motor Vehicle" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()