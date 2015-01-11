plot2 <- function (dir=NULL)
{
## This program needs the directory location where the actual data file resides , or it will presume data file located
## in its current directory and subsequent processing will continue.
## Setting up the processing directory 
if(is.null(dir)) dir<-paste(getwd(),"/",sep="")
landdir<-dir  
#landdir<-"/Users/malaydas/Documents/Data Science/Exploratory Data Analysis/ProgrammingAssignment1/"
setwd(landdir)

## Reading data from file "household_power_consumption.txt"
rawdata<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
data<-subset(rawdata,Date=='1/2/2007'| Date=='2/2/2007')

## Plotting Starts here ##
png("plot2.png",width = 480, height = 480, units = "px")
with(data,plot(strptime(as.vector(paste(data$Date,data$Time)),"%d/%m/%Y %H:%M:%S"),as.numeric(as.vector(data$Global_active_power)),type="l",xlab="",ylab="Global Active Power (Kilowatts)"))
dev.off()
}