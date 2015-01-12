# This R Script generates a bar plot of Total Emissions by Year and Type for Baltimore City using the NEI datasets.

# Read in data from RDS files
NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

# Create subset of data for Baltimore, MD
NEIBaltimore <- subset(NEI, fips=="24510")

# Create table of total emissions by year and type for Baltimore City
EmissionTotalsBaltimoreByType <- aggregate(Emissions ~ year+type, data=NEIBaltimore, FUN=sum);

# Generate plot and PNG file
qplot(year,Emissions,data=EmissionTotalsBaltimoreByType,facets=.~type,geom="path",main="Total Emission Trends for Baltimore City by Type");
ggsave(file="plot3.png");