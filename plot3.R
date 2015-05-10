# For more information on this function, please read the provided README file.
create_plot3 <- function() {
    
    # First, just get the column names from the first row.  Assume the file is in the directory.
    cols<-read.delim("household_power_consumption.txt", sep=";", nrows=1, header=TRUE)
    
    # Data for February 1st 2007 starts on row 66638.
    # Since we know that there is one row per minute, the number of rows we need is 
    # 2*24*60=2880, we can set that value explicitly.
    data<-read.delim("household_power_consumption.txt", sep=";", skip=66637, nrows=2880, header=FALSE, as.is=TRUE)
    
    # Attach the column names to the data set.
    names(data)<-names(cols)
    
    # Concatenate the Date and Time columns together and convert them to DateTimes
    DateTimes<-strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
    
    # Add the new dateTimes column to our data set
    dataWithDateTimes<-cbind(DateTimes,data)
    
    # Open a bitmap device so we can write the the appropriate file
    png(filename="plot3.png", width=480, height=480)
    
    # Draw a line plot of the energy sub metering data over time
    # Note: the "blue" seems to render in a purply color on my machine but I haven't found a better blue to use so far.
    plot(dataWithDateTimes$DateTimes, dataWithDateTimes$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(dataWithDateTimes$DateTimes, dataWithDateTimes$Sub_metering_2, col="red")
    lines(dataWithDateTimes$DateTimes, dataWithDateTimes$Sub_metering_3, col="blue")
    
    # Add a legend to the plot
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
    
    # Save the plot to file
    dev.off()
}