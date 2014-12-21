# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

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

# Make a plot showing the total PM2.5 emission from all sources for All Years
if(!exists("Total_Emissions")){
        Total_Emissions <- aggregate(Emissions ~ year, NEI, sum)
}

png("Plot 1.png")
plot(Total_Emissions, 
     type = "l",
     xlab = "Year", 
     ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()