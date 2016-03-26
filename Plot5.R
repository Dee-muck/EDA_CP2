##Q5. How have emissions from motor vehicle sources changed from 1999–2008 
##in Baltimore City?

library(ggplot2)
##Reading the files
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

##Look at the data via str, head functions and realize that motor vehicle==ON ROAD
baltimore_mv<- subset(NEI, fips == "24510" & type=="ON-ROAD", select=c(Emissions, year))

## just to prove, make the same subsetting via grep function
baltimore_data<- subset(NEI, fips == "24510")
vehicle_filter <- subset(SCC, grepl("[Mm]otor|[Vv]ehicles", EI.Sector))

# subset the emissions data based on coal source codes
TEbY_vehicle <- subset(baltimore_data, baltimore_data$SCC %in% vehicle_filter$SCC)

##Checking the total sum of EMissions
sum(TEbY_vehicle$Emissions)
##[1] 699.8347
sum(baltimore_mv$Emissions)
## [1] 699.8347  Equal!

# aggregate the emissions by year
TEbY_mv <- aggregate(TEbY_vehicle$Emissions, list(TEbY_vehicle$year),  sum)
##Assigning column names
colnames(TEbY_mv) <- c("year","Emissions")

##Plottimg in PNG
png(filename = "./plot5.png", width = 480, height = 480, units = "px", bg = "transparent")
ggplot(data=TEbY_mv, aes(x=factor(year), y=Emissions)) + 
        geom_bar(stat = "identity", fill="wheat") +
        theme_bw(base_family = "Avenir", base_size = 10) +
        xlab("Year") + 
        ylab("Total Emissions (tons)") + 
        ggtitle("PM2.5 Emissions in Baltimore City,\n from motor vehicles sources (1999 - 2008)")

##Closing the device
dev.off()
