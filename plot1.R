#Assignment didn't specifically request a function, so the script will execute on sourcing.

#Open and read the file
buffer<-read.table("household_power_consumption.txt",header=T,sep=";", stringsAsFactors=F)
#Convert the date column to usable dates
buffer$Date <- as.Date(buffer$Date, "%d/%m/%Y")
#drop the parts we don't care about
buffer2<- buffer [buffer$Date > "2007-01-31" & buffer$Date <= "2007-02-02",]
#clean up to free up some memory
remove(buffer)
#make a date time.  probably could have done this earlier.
buffer2$DateTime <- strptime(paste(as.character(buffer2$Date), buffer2$Time, sep=" "), format = "%Y-%m-%d %H:%M:%S")
#convert chars to nums
buffer2$Global_active_power <- as.numeric(buffer2$Global_active_power)
buffer2$Global_reactive_power <- as.numeric(buffer2$Global_reactive_power)
buffer2$Voltage <- as.numeric(buffer2$Voltage)
buffer2$Global_intensity <- as.numeric(buffer2$Global_intensity)
buffer2$Sub_metering_1 <- as.numeric(buffer2$Sub_metering_1)
buffer2$Sub_metering_2 <- as.numeric(buffer2$Sub_metering_2)

#give it a nice name
epc <- buffer2
remove (buffer2)

#open the device and make the plot! 
#notice that I used orangered as the colour.  That looked pretty close on the colour chart I found.
png("plot1.png",width=480,height=480,units="px")
hist(epc$Global_active_power, 15, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="orangered")
#close the device
dev.off()
