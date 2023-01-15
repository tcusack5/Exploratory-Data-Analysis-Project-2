## 5. How have emissions from motor vehicle sources changed from 1999–2008 in 
## Baltimore City?

## Load packages
library(ggplot2)
library(reshape2)
library(dplyr)

#Read data files 
data <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge data frames
left_join(SCC, data, by = "SCC")
merged <- data %>% as_tibble() %>% left_join(SCC[, c("SCC", "EI.Sector")],
                                             by = "SCC")

#Subset motor vehicle data
mvSubsetData <- merged[grep("vehicle", merged$EI.Sector, ignore.case=TRUE),]
mvBaltimoreSubset <- mvSubsetData[mvSubsetData$fips == "24510",]
totalMVData <- with(mvBaltimoreSubset, tapply(Emissions, year, sum))

#Plot
png(filename="plot5.png")
barplot(totalMVData, names.arg = names(totalMVData), 
        main = "Total Emissions by Year per Vehicle PM2.5", 
        xlab = "Year", 
        ylab = "PM2.5 Emissions (Tons)", 
        ylim = c(0, 400))
dev.off()

