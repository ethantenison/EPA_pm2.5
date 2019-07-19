#plot 3 
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
baltimore_type <- summarySCC_PM25 %>% filter(fips == "24510") %>% group_by(year, type)
options(scipen = 999)


#ploting 
b <-ggplot(baltimore_type, aes(factor(year), emissions)) + geom_bar(stat = "identity", fill = "steelblue") + theme_minimal() + labs(title = "PM2.5 in Baltimore (1999-2008) by type", x = "Year") + facet_wrap(~type)
b

ggsave("plot3.png")

