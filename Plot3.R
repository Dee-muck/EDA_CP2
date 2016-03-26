##Q3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

##including ggplot2
library(ggplot2)

##Reading the files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

##Subsetting the data to obtain Baltimore's data
baltimore_data2<- subset(NEI, fips == "24510", select=c(Emissions,type, year))

##aggregating data
TEbY_balt_type <- aggregate(baltimore_data2$Emissions, 
                            list(type = baltimore_data2$type, year = baltimore_data2$year), sum)

colnames(TEbY_balt_type) <- c("type", "year","Emissions")

##Plottimg in PNG
png(filename = "./plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
ggplot(data=TEbY_balt_type, aes(x=year, y=Emissions, group=type, colour=type)) + 
        geom_line() + 
        geom_point() + 
        theme_bw(base_family = "Avenir", base_size = 10) +
        xlab("Year") + 
        ylab("Total Emissions (tons)") + 
        ggtitle("PM2.5 Emissions in Baltimore City, Maryland,\n by source type (1999 - 2008)")

##Closing the device
dev.off()




