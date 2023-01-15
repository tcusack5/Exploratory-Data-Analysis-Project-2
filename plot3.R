## 3. Of the four types of sources indicated by the \color{red}{\verb|type|}type
## (point, nonpoint, onroad, nonroad) variable, which of these four sources have
## seen decreases in emissions from 1999–2008 for Baltimore City? Which have 
## seen increases in emissions from 1999–2008? Use the ggplot2 plotting system 
## to make a plot answer this question.

## Load packages
library(ggplot2)
library(reshape2)

#Read data file
data <- readRDS("summarySCC_PM25.rds")

#Subset of Baltimore data
baltimoreData <- data[data$fips == "24510",]
baltimoreDataByType <- data.frame(with(baltimoreData, tapply(Emissions, list(year, type), sum)))

#Reshape this data
plotData <- melt(as.matrix(baltimoreDataByType))
names(plotData) <- c("year", "type", "value")

#Plot
g <- ggplot(plotData, aes(year, value)) +
  geom_line(aes(color = type)) +
  ggtitle("Emissions in Baltimore City by Type") +
  xlab("Year")
  ylab("Emissions of PM2.5 (Tons)") +
  theme_bw()
ggsave("plot3.png", plot = g, device = "png")