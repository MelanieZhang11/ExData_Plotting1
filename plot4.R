library(dplyr)

## load data into R

power <- read.table("household_power_consumption.txt",sep = ";",header = TRUE)
power_new <- power
power_new$Date <- as.character(power_new$Date)
power_new$Time <- as.character(power_new$Time)

temp <- paste(power_new$Date,power_new$Time, sep = " ")
power_new$Date <- as.Date(power_new$Date,format="%d/%m/%Y")
power_new$Time <- strptime(temp,format = "%d/%m/%Y %H:%M:%S")

power3 <- subset(power_new,power_new$Date=="2007-02-01"|power_new$Date=="2007-02-02")
power3$Global_active_power <- as.numeric(as.character(power3$Global_active_power))

## plot panel

par(mfcol=c(2,2))

##graph 1
plot(power3$Time,power3$Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab="")
lines(power3$Time,power3$Global_active_power)

##graph 2
power3$Sub_metering_1 <- as.numeric(as.character(power3$Sub_metering_1))
power3$Sub_metering_2 <- as.numeric(as.character(power3$Sub_metering_2))

plot(power3$Time,power3$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
lines(power3$Time,power3$Sub_metering_1)
lines(power3$Time,power3$Sub_metering_2, col="red")
lines(power3$Time,power3$Sub_metering_3, col="blue")
legend("topright",lty = c(1,1),col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##graph 3
power3$Voltage <- as.numeric(as.character(power3$Voltage))
plot(power3$Time,power3$Voltage,type="n",ylab="Voltage",xlab="Datetime")
lines(power3$Time,power3$Voltage)

##graph 4

power3$Global_reactive_power <- as.numeric(as.character(power3$Global_reactive_power))
plot(power3$Time,power3$Global_reactive_power,type="n",ylab="Global_reacitve_power",xlab="Datetime")
lines(power3$Time,power3$Global_reactive_power)

## Output PNG file
dev.cur()
dev.copy(png,file = "plot4.png")
dev.off()
