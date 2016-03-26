##Q2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
##(𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to mak
##e a plot answering this question.

##Reading the files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

##Subsetting the data to obtain Baltimore's data
baltimore_data<- subset(NEI, fips == "24510", select=c(Emissions, year))

##Calculating total emission by year
TEbY_balt<- tapply(baltimore_data$Emissions, baltimore_data$year, sum)

##Plottimg in PNG
png(filename = "./plot2.png", width = 640, height = 640, units = "px", bg = "transparent")
barplot(TEbY_balt,main="Total emissions from PM2.5 in the Baltimore City, Maryland (1999-2008)",
        xlab="Years",ylab="Total Emissions, tons", col="lightsalmon1")

##Closing the device
dev.off()
