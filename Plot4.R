##Q4. Across the United States, how have emissions from coal combustion-related 
##sources changed from 1999–2008?

##including ggplot2
library(ggplot2)

##Reading the files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

##merging datasets
merged<- merge(NEI,SCC, by="SCC")

##Filtering by coal source
coal_filter <- subset(SCC, grepl("[Cc]oal", EI.Sector) | grepl("[Cc]oal", Short.Name))

# subset the emissions data based on coal source codes
TEbY_coal <- subset(NEI, NEI$SCC %in% coal_filter$SCC)

# aggregate the emissions by year
TEbY_coal2 <- aggregate(TEbY_coal$Emissions, list(TEbY_coal$year),  sum)
##Assigning column names
colnames(TEbY_coal2) <- c("year","Emissions")

##Plottimg in PNG
png(filename = "./plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
ggplot(data=TEbY_coal2, aes(x=year, y=Emissions)) + 
        geom_line(color="steelblue") + 
        geom_point() + 
        theme_bw(base_family = "Avenir", base_size = 10) +
        xlab("Year") + 
        ylab("Total Emissions (tons)") + 
        ggtitle("Total PM2.5 Emissions in USA,\n from coal combustion related sources (1999 - 2008)")


##Closing the device
dev.off()
