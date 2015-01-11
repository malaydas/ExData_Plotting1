plot1 <- function(dir=NULL)
{

## Setting up the processing directory  
if(is.null(dir)) dir<-paste(getwd(),"/",sep="")
landdir<-dir  
#landdir<-"/Users/malaydas/Documents/Data Science/Exploratory Data Analysis/ProgrammingAssignment1/"
setwd(landdir)

## Reading data from file "household_power_consumption.txt"
rawdata<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
data<-subset(rawdata,Date=='1/2/2007'| Date=='2/2/2007')

## Plotting Starts here ##
png("plot1.png",width = 480, height = 480, units = "px")
hist(as.numeric(as.vector(data$Global_active_power)),col="red",xlab="Global Active Power (Kilowatts)",main="Global Active Power")
dev.off()
}