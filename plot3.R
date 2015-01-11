plot3<- function(dir=NULL)
{
## This program needs the directory location where the actual data file resides , or it will presume data file located
## in its current directory and subsequent processing will continue.
## Library Inclusion  
library(tidyr)

## Setting up the processing directory 
if(is.null(dir)) dir<-paste(getwd(),"/",sep="")
landdir<-dir
#landdir<-"/Users/malaydas/Documents/Data Science/Exploratory Data Analysis/ProgrammingAssignment1/"
setwd(landdir)

## Reading data from file "household_power_consumption.txt"
rawdata<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
data<-subset(rawdata,Date=='1/2/2007'| Date=='2/2/2007')

## Bringing Sub_metering_1 to 3 in one column , in order to accomodate in Base plotting system
workdata<-data[,c("Date","Time","Sub_metering_1","Sub_metering_2","Sub_metering_3")]
pivotdata<-gather(workdata,Sub_metering,value,-Date,-Time)
pivotdata$DateTime<-paste(pivotdata$Date,pivotdata$Time)

## Plotting Starts here ##
png("plot3.png",width = 480, height = 480, units = "px")
with(pivotdata,plot(strptime(as.vector(DateTime),"%d/%m/%Y %H:%M:%S"),value,type="n",xlab="",ylab="Energy sub metering"))
with(subset(pivotdata,Sub_metering=="Sub_metering_1"),lines(strptime(as.vector(DateTime),"%d/%m/%Y %H:%M:%S"),value,col="black"))
with(subset(pivotdata,Sub_metering=="Sub_metering_2"),lines(strptime(as.vector(DateTime),"%d/%m/%Y %H:%M:%S"),value,col="red"))
with(subset(pivotdata,Sub_metering=="Sub_metering_3"),lines(strptime(as.vector(DateTime),"%d/%m/%Y %H:%M:%S"),value,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

}

