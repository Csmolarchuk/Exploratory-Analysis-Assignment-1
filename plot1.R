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

#Plot histogram

hist(df$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="Red")

#Convert plot to png
dev.copy(png, file = "plot1.png")
dev.off()