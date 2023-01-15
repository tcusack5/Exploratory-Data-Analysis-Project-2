## 1. Have total emissions from PM2.5 decreased in the United States from 1999 
## to 2008? Using the base plotting system, make a plot showing the total PM2.5
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## Read data file
data <- readRDS("summarySCC_PM25.rds")

## Calculate emissions per year
emissions <- aggregate(data$Emissions, by=list(year=data$year),FUN=sum)

## Plot
png(filename="plot1.png")
plot(emissions$year, emissions$x, type="l", main = "Total Emissions in Baltimore
     City (PM2.5)", xlab="Year", ylab="Total PM2.5 Emissions (Tons)")
dev.off()
