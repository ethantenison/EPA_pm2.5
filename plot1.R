#plot1 
library(dplyr)
library(janitor)
library(ggplot2)
library(stringr)
library(grid)
library(gridExtra)

#data cleaning 
summarySCC_PM25 <- readRDS("summarySCC_PM25.rds")
summarySCC_PM25 <- clean_names(summarySCC_PM25)
Source_Classification_Code <- readRDS("Source_Classification_Code.rds")
Source_Classification_Code <- clean_names(Source_Classification_Code)
options(scipen = 999)
by_year <- summarySCC_PM25 %>% group_by(year) %>% summarise(total = sum(emissions))
by_year$year <- as.factor(by_year$year)

#plotting 
png("plot1.png", width = 480, height = 480 )
barplot(by_year$total, main="Total Emissions from PM2.5 from 1999-2008",  names.arg=c("1999", "2002", "2005", "2008"), ylab = "Emissions in Tons")
dev.off()


