# This R Script generates a bar plot of Total Emissions by Year for Baltimore using the NEI datasets.

# Read in data from RDS files
NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

# Create subset of data for Baltimore, MD
NEIBaltimore <- subset(NEI, fips=="24510")

# Create table of total emissions by year
EmissionTotalsBaltimore <- aggregate(Emissions ~ year, data=NEIBaltimore, FUN=sum)

# Generate PNG file, default is 480 x 480
png(filename="plot2.png");
par(mfrow=c(1,1));
with(EmissionTotalsBaltimore,barplot(Emissions,names.arg=year,col="steelblue",border=FALSE, ylab = "Total PM2.5 Emissions", xlab = "Years"));
title("Total PM2.5 Emissions by Year (Baltimore, MD)");
dev.off();