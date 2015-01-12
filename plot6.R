# This R Script generates a plot showing how emissions from motor vehicle sources changed from 1999-2008 in Baltimore City using the NEI datasets.

# Read in data from RDS files
NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

# Merge Short Names from the SCC dataset into the NEI dataset
SCCShort <- data.frame(SCC=SCC$SCC,Short.Name=SCC$Short.Name);
NEIMerged <- merge(NEI,SCCShort,by="SCC");

# Subset Rows with Motor Vehicle sources
NEIMerged <-subset(NEIMerged,grepl("VEH",toupper(NEIMerged$Short.Name),fixed=T));

# Create subset of data for Baltimore City, MD and LA County, CA
NEIMerged <- subset(NEIMerged, fips=="24510" | fips=="06037");
NEIMerged$fips <- factor(NEIMerged$fips,levels=c("24510","06037"),labels=c("Baltimore City", "Los Angeles County"))

# Create table of total emissions by year for Motor Vehicle Sources
EmissionTotals <- aggregate(Emissions ~ year + fips, data=NEIMerged, FUN=sum);

# Generate plot and save to PNG file
qplot(as.factor(year),Emissions,data=EmissionTotals,facets=.~fips,geom="bar",stat="identity",main="Comparison of Emissions for Motor Vehicles", xlab="Year");
ggsave(file="plot6.png");