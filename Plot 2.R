# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

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

#Subset the Data for Baltimore, MD 
Baltimore <- NEI[NEI$fips=="24510", ]

# Make a plot showing the total PM2.5 emission in Baltimore, MD for All Years
Total_Baltimore_Emissions <- aggregate(Emissions ~ year, Baltimore, sum)


png("Plot 2.png")
plot(Total_Baltimore_Emissions, 
     type = "l",
     xlab = "Year", 
     ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()