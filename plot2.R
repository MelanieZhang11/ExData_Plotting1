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

## plot line
plot(power3$Time,power3$Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab="")
lines(power3$Time,power3$Global_active_power)

## Output PNG file
dev.cur()
dev.copy(png,file = "plot2.png")
dev.off()