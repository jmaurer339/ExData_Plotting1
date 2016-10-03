#For Graph 1

#Read In Data
powerdata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
powerdata$Date_t <- as.Date(powerdata$Date, "%d/%m/%Y")

# Select Just Two Days
graphdata <- subset(powerdata, Date_t == '2007-02-01' | Date_t == '2007-02-02')

#Create Combined Date-Time variable
graphdata$datetime <-  paste(graphdata$Date, graphdata$Time)
graphdata$datetime <- strptime(graphdata$datetime, format="%d/%m/%Y %H:%M:%S") 


#Convert Other Fields To Numeric
graphdata$Global_active_power <- 
  as.numeric(levels(graphdata$Global_active_power))[graphdata$Global_active_power]

graphdata$Global_reactive_power <- 
  as.numeric(levels(graphdata$Global_reactive_power))[graphdata$Global_reactive_power]

graphdata$Voltage <- 
  as.numeric(levels(graphdata$Voltage))[graphdata$Voltage]

graphdata$Global_intensity <- 
  as.numeric(levels(graphdata$Global_intensity))[graphdata$Global_intensity]

graphdata$Sub_metering_1 <- 
  as.numeric(levels(graphdata$Sub_metering_1))[graphdata$Sub_metering_1]

graphdata$Sub_metering_2 <- 
  as.numeric(levels(graphdata$Sub_metering_2))[graphdata$Sub_metering_2]

#Create The Plot
png(file="plot1.png")
hist(graphdata$Global_active_power, 
      main = 'Global Active Power', 
      xlab = 'Global Active Power (kilowatts)',
      col = "red"  )
dev.off()






## sapply(graphdata,class)