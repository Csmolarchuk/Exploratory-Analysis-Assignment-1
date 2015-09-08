
#Download and unzip file
file <- "power_consumption.zip"

if (!file.exists(file)){
  Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(Url, file, method="libcurl")
}  
if (!file.exists("power_consumption")) { 
  unzip(file) 
}

#Read in text file

data <- read.table("./power_consumption/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#Convert dates using as.date

data$Date<-as.Date(data$Date, format="%d/%m/%Y")

#Subset dates from 2007-02-01 and 2007-02-02

df<-subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)

#Transform/Process the data for plotting
df$Global_active_power<-as.numeric(df$Global_active_power)
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)

#Plot data
with(df, 
     {plot(timestamp, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
      lines(timestamp, Sub_metering_2, type="l", col="red")
      lines(timestamp, Sub_metering_3, type="l", col="blue")
      legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}
)

#Convert plot to png
dev.copy(png, file = "plot3.png")
dev.off()