#Data Exploration Final Project 
library(dplyr)
library(janitor)

summarySCC_PM25 <- clean_names(summarySCC_PM25)
Source_Classification_Code <- clean_names(Source_Classification_Code)
#Question 1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
by_year <- summarySCC_PM25 %>% group_by(year) %>% summarise(total = sum(emissions))
by_year$year <- as.factor(by_year$year)

barplot(by_year$total, main="Total Emissions from PM2.5 from 1999-2008",  names.arg=c("1999", "2002", "2005", "2008"))


#Question 2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland ?
baltimore <- filter(summarySCC_PM25, fips == "24510")
baltimore_byyear <- baltimore %>% group_by(year) %>% summarise(total = sum(emissions))

barplot(baltimore_byyear$total, main="Total Emissions from PM2.5 in Baltimore from 1999-2008",  
        names.arg=c("1999", "2002", "2005", "2008"))


#question 3 Of the four types of sources indicated by type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources 
#have seen decreases in emissions from 1999–2008 for Baltimore City? Which have 
#seen increases in emissions from 1999–2008? 
library(ggplot2)

baltimore_type <- summarySCC_PM25 %>% filter(fips == "24510") %>% group_by(year, type)

b <-ggplot(baltimore_type, aes(factor(year), emissions)) + geom_bar(stat = "identity", fill = "steelblue") + theme_minimal() + labs(title = "PM2.5 in Baltimore (1999-2008) by type", x = "Year") + facet_wrap(~type)
b


#Question 4 Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999–2008?
coal_ids <- filter(Source_Classification_Code, ei_sector == "Fuel Comb - Electric Generation - Coal")
