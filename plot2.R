## 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? Use 
## the base plotting system to make a plot answering this question.

## Read data file
data <- readRDS("summarySCC_PM25.rds")

## Subset out Baltimore data & calculate total emissions per year
baltimoreData <- subset(data, data$fips=="24510")
dataPerYear <- aggregate(baltimoreData$Emissions, by=list(baltimoreData$year), 
                         FUN=sum)

## Plot
png(filename="plot2.png")
plot(dataPerYear$Group.1, dataPerYear$x, type="l", main="Total Emissions in 
     Baltimore City (PM2.5)", xlab="Year", ylab="Total Emissions (Tons)")
dev.off()