plot4<- function(dir=NULL)
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
  lf<-matrix(1:4,nrow=2,ncol=2)
  png("plot4.png",width = 480, height = 480, units = "px")
  ## defining the grid to place individual plot
  layout(lf)
  
  ## Plotting Global Active Power
  with(data,plot(strptime(as.vector(paste(data$Date,data$Time)),"%d/%m/%Y %H:%M:%S"),as.numeric(as.vector(data$Global_active_power)),type="l",xlab="",ylab="Global Active Power"))  
  
  ## Plotting Sub_metering 1 to 3
  with(pivotdata,plot(strptime(as.vector(DateTime),"%d/%m/%Y %H:%M:%S"),value,type="n",xlab="",ylab="Energy sub metering"))
  with(subset(pivotdata,Sub_metering=="Sub_metering_1"),lines(strptime(as.vector(DateTime),"%d/%m/%Y %H:%M:%S"),value,col="black"))
  with(subset(pivotdata,Sub_metering=="Sub_metering_2"),lines(strptime(as.vector(DateTime),"%d/%m/%Y %H:%M:%S"),value,col="red"))
  with(subset(pivotdata,Sub_metering=="Sub_metering_3"),lines(strptime(as.vector(DateTime),"%d/%m/%Y %H:%M:%S"),value,col="blue"))
  legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  ## Plotting Voltage and Global Reactive Power
  with(data,{
  plot(strptime(as.vector(paste(data$Date,data$Time)),"%d/%m/%Y %H:%M:%S"),as.numeric(as.vector(data$Voltage)),type="l",xlab="datetime",ylab="Voltage")
  plot(strptime(as.vector(paste(data$Date,data$Time)),"%d/%m/%Y %H:%M:%S"),as.numeric(as.vector(data$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
  })
  
  dev.off()
  
}


