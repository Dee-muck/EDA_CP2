## Q1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
##Using the base plotting system, make a plot showing the total PM2.5 emission from all 
##sources for each of the years 1999, 2002, 2005, and 2008.

##Above all we set language preferences to English  and save current settings
## In order to save my russian environment
curr_locale <- Sys.getlocale("LC_TIME")

## To set it in english
Sys.setlocale("LC_TIME","en_US.UTF-8")

## To come back to local setting later
## Sys.setlocale("LC_TIME",curr_locale)

##Setting working directory
setwd("./EDA_CP")

##Reading the files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

##Calculating total emission by year
TEbY<- tapply(NEI$Emissions, NEI$year, sum)

##Plottimg in PNG
png(filename = "./plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
barplot(TEbY,main="Total emissions from PM2.5 in USA (1999-2008)",xlab="Years",ylab="Total Emissions, tons", col="lightblue")

##Closing the device
dev.off()
