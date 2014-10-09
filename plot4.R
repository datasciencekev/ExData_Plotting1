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
png("plot4.png",width=480,height=480,units="px")

par(mfrow = c(2, 2))

#first plot
with (epc, plot(DateTime, Global_active_power, type="n", xlab="", ylab="Global Active Power"))
with (epc, lines(DateTime, Global_active_power))

#second plot
with (epc, plot(DateTime, Voltage, type="n", xlab="datetime", ylab="Voltage"))
with (epc, lines(DateTime, Voltage))

#third plot
with (epc, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with (epc, lines(DateTime, Sub_metering_1, col="black"))
with (epc, lines(DateTime, Sub_metering_2, col="orangered"))
with (epc, lines(DateTime, Sub_metering_3, col="deepskyblue2"))
legend("topright", col=c("black", "orangered", "deepskyblue2"), lty=1, bty="n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#fourth plot
with (epc, plot(DateTime, Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power"))
with (epc, lines(DateTime, Global_reactive_power))

#close the device
dev.off()
