# For more information on this function, please read the provided README file.
create_plot3 <- function() {
    
    # First, just get the column names from the first row.  Assume the file is in the directory.
    cols<-read.delim("household_power_consumption.txt", sep=";", nrows=1, header=TRUE)
    
    # Data for February 1st 2007 starts on row 66638.
    # Since we know that there is one row per minute, the number of rows we need is 
    # 2*24*60=2880, we can set that value explicitly.
    data<-read.delim("household_power_consumption.txt", sep=";", skip=66637, nrows=2880, header=FALSE)
    
    # Attach the column names to the data set.
    names(data)<-names(cols)
    
    # Draw a histogram of the global active power data
    hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
    
    # Save the histogram to file
    dev.copy(png, file="plot1.png")
    dev.off()
}