## 6. Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California 
## (\color{red}{\verb|fips == "06037"|}fips == "06037"). Which city has seen 
## greater changes over time in motor vehicle emissions?

## Load Packages
library(ggplot2)
library(reshape2)
library(dplyr)

## Read data files
data <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge data frames
left_join(SCC, data, by = "SCC")
mergedData <- data %>% as_tibble() %>% left_join(SCC[, c("SCC", "EI.Sector")], 
                                            by = "SCC")

#Subset data and calculate sum
mvSubsetData <- mergedData[grep("vehicle", mergedData$EI.Sector,
                                ignore.case=TRUE),]
baltimoreLASubsetData <- mvSubsetData[mvSubsetData$fips == "24510" | 
                                        mvSubsetData$fips == "06037",]
totalMVData <- with(baltimoreLASubsetData, tapply(Emissions, list(year,fips), 
                                                  sum))

## Combine desired data
plotData <- melt(totalMVData)
names(plotData) <- c("year", "county", "value")
plotData$county[plotData$county == 6037] <- "Los Angeles County"
plotData$county[plotData$county == 24510] <- "Baltimore City"

## Plot
g <- ggplot(plotData, aes(year, value)) +
  geom_line(aes(color = county)) +
  ggtitle("Emissions in Baltimore City and Los Angeles County PM2.5") +
  xlab("Year")+ 
  ylab("PM2.5 Emissions (Tons)") +
  theme_bw()
ggsave("plot6.png", plot = g, device = "png")