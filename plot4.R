#For Graph 4

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
yrange <- range(c(graphdata$Sub_metering_1,graphdata$Sub_metering_2, graphdata$Sub_metering_3))

png(file="plot4.png")
par(mfrow = c(2,2))
with(graphdata, { 
  plot(datetime, Global_active_power, typ = 'l', 
     ylab = 'Global Active Power (kilowatts)', xlab = "" )
  plot(datetime, Voltage, typ = 'l') 
  
  plot(graphdata$datetime,  graphdata$Sub_metering_1, typ = 'l', col = 'black', ylim=yrange, ylab = 'Energy sub Metering', xlab = '' ) 
  par(new=T)
  plot(graphdata$datetime,  graphdata$Sub_metering_2, typ = 'l', col = 'red', ylim=yrange, ylab = 'Energy sub Metering', xlab = '' )  
  par(new=T)
  plot(graphdata$datetime,  graphdata$Sub_metering_3, typ = 'l', col = 'blue', ylim=yrange,  ylab = 'Energy sub Metering', xlab = '' )
  legend("topright",
         col = c("black", "blue"  ,   "red"  ),
         legend = c( "Sub_metering_1", "Sub_metering_2" ,  "Sub_metering_3"   ),
         lty=c(1,1), # gives the legend appropriate symbols (lines) 
         lwd=c(2.5,2.5), bty = "n"
  )
  
  plot(datetime, Global_reactive_power, typ = 'l') 
})
dev.off()


