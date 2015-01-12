# This R Script generates a bar plot of Total Emissions by Year for Coal Combustible-related Sources using the NEI datasets.

# Read in data from RDS files
NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

# Merge Short Names from the SCC dataset into the NEI dataset
SCCShort <- data.frame(SCC=SCC$SCC,Short.Name=SCC$Short.Name)
NEIMerged <- merge(NEI,SCCShort,by="SCC")

# Subset Rows with Coal Combustible sources
NEIMerged <-subset(NEIMerged,grepl("COAL",toupper(NEIMerged$Short.Name),fixed=T) & grepl("COMB",toupper(NEIMerged$Short.Name),fixed=T))

# Create table of total emissions by year for Coal Sources
EmissionTotalsCoal <- aggregate(Emissions ~ year, data=NEIMerged, FUN=sum);

# Generate plot and save to PNG file
qplot(as.factor(year),Emissions,data=EmissionTotalsCoal,geom="bar",stat="identity",main="Total Emissions by Year for Coal Sources", xlab="Year");
ggsave(file="plot4.png");