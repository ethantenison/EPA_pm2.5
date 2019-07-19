#Plot 4 
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
coal_ids <- filter(Source_Classification_Code, ei_sector == "Fuel Comb - Electric Generation - Coal")
coal <- filter(summarySCC_PM25, scc %in% coal_ids$scc)
coal_by_year <- coal %>% group_by(year) %>% summarise(total = sum(emissions))

#plotting 
c <- ggplot(coal_by_year, aes(factor(year), total)) + geom_bar(stat = "identity", fill = "chartreuse") + labs(title = "PM2.5 from Coal in the US from (1999 - 2008)", x = "Year", y = "Total Coal Emissions in Tons")
c
ggsave("plot4.png")
