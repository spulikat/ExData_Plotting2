# This R Script generates a bar plot of Total Emissions by Year using the NEI datasets.

# Read in data from RDS files
NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

# Create table of total emissions by year
EmissionTotals <- aggregate(Emissions ~ year, data=NEI, FUN=sum);

# Generate PNG file, default is 480 x 480
png(filename="plot1.png");
par(mfrow=c(1,1));
with(EmissionTotals,barplot(Emissions,names.arg=year,width=30,col="plum",border=FALSE, ylab = "Total PM2.5 Emissions", xlab = "Years"));
title("Total PM2.5 Emissions by Year");
dev.off();