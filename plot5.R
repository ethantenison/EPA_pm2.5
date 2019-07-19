#plot5 
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
motor_vehciles_scc <- dplyr::filter(Source_Classification_Code, str_detect(scc_level_two, 'Vehicles'))
baltimore <- filter(summarySCC_PM25, fips == "24510")
motor_by_year <- baltimore_motor_vehicle %>% group_by(year) %>% summarise(total = sum(emissions))

#plotting
m <- ggplot(motor_by_year, aes(factor(year), total)) + geom_bar(stat = "identity", fill = "rosybrown") + labs(title = "Motor Vehicle Pollution in Baltimore", x = "Year", y = "Total Vehicle Emissions in Tons") 
m

ggsave("plot5.png")