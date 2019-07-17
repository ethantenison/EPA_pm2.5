#Data Exploration Final Project 
library(dplyr)
library(janitor)

summarySCC_PM25 <- clean_names(summarySCC_PM25)
Source_Classification_Code <- clean_names(Source_Classification_Code)
#Question 1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
options(scipen = 999)
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

options(scipen = 999)
b <-ggplot(baltimore_type, aes(factor(year), emissions)) + geom_bar(stat = "identity", fill = "steelblue") + theme_minimal() + labs(title = "PM2.5 in Baltimore (1999-2008) by type", x = "Year") + facet_wrap(~type)
b


#Question 4 Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999–2008?
coal_ids <- filter(Source_Classification_Code, ei_sector == "Fuel Comb - Electric Generation - Coal")
coal <- filter(summarySCC_PM25, scc %in% coal_ids$scc)

coal_by_year <- coal %>% group_by(year) %>% summarise(total = sum(emissions))

options(scipen = 999)
c <- ggplot(coal_by_year, aes(factor(year), total)) + geom_bar(stat = "identity", fill = "chartreuse") + labs(title = "PM2.5 from Coal in the US from (1999 - 2008)", x = "Year", y = "Total Coal Emissions")
c
#Question 5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(stringr)
motor_vehciles_scc <- dplyr::filter(Source_Classification_Code, str_detect(scc_level_two, 'Vehicles'))

baltimore_motor_vehicle <- filter(baltimore, scc %in% motor_vehciles_scc$scc)

motor_by_year <- baltimore_motor_vehicle %>% group_by(year) %>% summarise(total = sum(emissions))

options(scipen = 999)
m <- ggplot(motor_by_year, aes(factor(year), total)) + geom_bar(stat = "identity", fill = "rosybrown") + labs(title = "Motor Vehicle Pollution in Baltimore (1999 - 2008)", x = "Year", y = "Total Vehicle Emissions") + ylim(0,  5000)
m

#Question 6 Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
#sources in Los Angeles County, California (fips=="06037"). Which city has seen greater changes over time in 
#motor vehicle emissions?
LA <- filter(summarySCC_PM25, fips == "06037")
LA_motor_vehicle <- filter(LA, scc %in% motor_vehciles_scc$scc)

LAmotor_by_year <- LA_motor_vehicle %>% group_by(year) %>% summarise(total = sum(emissions))

options(scipen = 999)
LAm <- ggplot(LAmotor_by_year, aes(factor(year), total)) + geom_bar(stat = "identity", fill = "darkblue") + labs(title = "Motor Vehicle Pollution in Los Angelos County(1999 - 2008)", x = "Year", y = "Total Vehicle Emissions") + ylim(0,5000 )
LAm

grid.arrange(m, LAm, nrow = 1)
