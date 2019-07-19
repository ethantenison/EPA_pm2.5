#plot2 
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
baltimore <- filter(summarySCC_PM25, fips == "24510")
baltimore_byyear <- baltimore %>% group_by(year) %>% summarise(total = sum(emissions))


#ploting 
png("plot2.png", width = 480, height = 480 )
barplot(baltimore_byyear$total, main="Total Emissions from PM2.5 in Baltimore from 1999-2008",  
        names.arg=c("1999", "2002", "2005", "2008"), ylab = "Emissions in Tons")
dev.off()