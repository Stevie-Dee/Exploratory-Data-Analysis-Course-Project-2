# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the 
# ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

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

# Make a plot showing the source of PM2.5 emission in Baltimore, MD for All Years
Total_Baltimore_Emissions_By_Type <- aggregate(Emissions ~ year + type, Baltimore, sum)

png("Plot 3.png")
x <- qplot(year, 
      Emissions, 
      data = Total_Baltimore_Emissions_By_Type, 
      color = type, 
      geom = "line",
      xlab = "Year", 
      ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
      main = expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year and Type"))
print(x)
dev.off()