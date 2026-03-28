library(tidyverse)

data <- as.data.frame(household_power_consumption)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
df <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

df$datetime <- strptime(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")

df$Global_active_power <- as.numeric(df$Global_active_power)



# Ensure numeric
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

df$datetime <- as.POSIXct(df$datetime)

# Plot without y-axis
plot(df$datetime,
     df$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n",
     yaxt = "n", 
     ylim = c(-1,40))   # remove default y-axis

# Add other lines
lines(df$datetime, df$Sub_metering_2, col = "red")
lines(df$datetime, df$Sub_metering_3, col = "blue")

# Custom y-axis ONLY till 30
axis(2, at = seq(0, 30, by = 10))

# Custom x-axis
axis(1,
     at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
     labels = c("Thu", "Fri", "Sat"))

# Legend with box
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "o")