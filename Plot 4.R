#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999–2008?

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

#Subset the Coal Data
if(!exists("logical_coal_vector")){
        logical_coal_vector <- grepl("coal", Merged_NEI_SCC$Short.Name, ignore.case=TRUE)
}

if(!exists("coal_data")){
        coal_data <- Merged_NEI_SCC[logical_coal_vector, ]
}

# Make a plot showing emissions from coal-related sources
Coal_Related_Emissions <- aggregate(Emissions ~ year, coal_data, sum)

png("Plot 4.png")
plot(Coal_Related_Emissions, 
     type = "l",
     xlab = "Year", 
     ylab = expression("Coal-Related" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total US Coal-Related" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()