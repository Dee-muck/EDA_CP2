##Q5. Compare emissions from motor vehicle sources in Baltimore City with 
##emissions from motor vehicle sources in Los Angeles County, California 
##(𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over
##time in motor vehicle emissions?

library(ggplot2)
##Reading the files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

#Subsetting the data to obtain Baltimore's and LAs' data
##As we did and proved in 5th question, we can use ON-ROAD filter
bal_LA_data2<- subset(NEI, (fips == "24510" |fips == "06037") & type=="ON-ROAD", select=c(fips,Emissions,type, year))

# aggregate the emissions by year and City(fips)
TEbY_mv2 <- aggregate(bal_LA_data2$Emissions, list(bal_LA_data2$fips,bal_LA_data2$year),  sum)
##Assigning column names
colnames(TEbY_mv2) <- c("fips","year","Emissions")

##Plottimg in PNG
png(filename = "./plot6.png", width = 480, height = 480, units = "px", bg = "transparent")
ggplot(data=TEbY_mv2, aes(x=year, y=Emissions, group=fips, colour=fips)) + 
        geom_line() + 
        geom_point() + 
        theme_bw(base_family = "Avenir", base_size = 10) +
        xlab("Year") + 
        ylab("Total Emissions (tons)") + 
        ggtitle("PM2.5 Emissions in Baltimore City vs Los Angeles, California\n from motor vehicle sources (1999 - 2008)") +
        scale_colour_discrete(name="County", labels=c("Los Angeles, \nCalifornia", "Baltimore City, Maryland"))

##Closing the device
dev.off()


