## 4. Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

## Load Packages
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

#Subset coal data
coalData <- merged[grep("coal", merged$EI.Sector, ignore.case=TRUE),]
totalCoalData <- with(coalData, tapply(Emissions, year, sum))

#Plot
png(filename="plot4.png")
barplot(totalCoalData, names.arg = names(totalCoalData), 
        main = "Total Coal Emissions by Year", 
        xlab = "Year", 
        ylab = "PM2.5 Emissions (Tons)",
        ylim = c(0, 600000))
dev.off()