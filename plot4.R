library(tidyverse)

data <- as.data.frame(household_power_consumption)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
df <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

df$datetime <- strptime(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")




# Ensure all required columns are numeric
cols <- c("Global_active_power", "Global_reactive_power",
          "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

for (col in cols) {
  df[[col]] <- as.numeric(as.character(df[[col]]))
}

# Ensure datetime format
df$datetime <- as.POSIXct(df$datetime)

# Set 2x2 layout
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

# -----------------------
# Plot 1: Global Active Power
# -----------------------
plot(df$datetime, df$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     xaxt = "n",
     yaxt = "n",
     ylim = c(-0.1, 8))

# Y-axis with 0 included
axis(2, at = c(0, 2, 4, 6))

axis(1,
     at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
     labels = c("Thu", "Fri", "Sat"))

# -----------------------
# Plot 2: Voltage
# -----------------------
plot(df$datetime, df$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     xaxt = "n")

axis(1,
     at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
     labels = c("Thu", "Fri", "Sat"))

# -----------------------
# Plot 3: Sub metering
# -----------------------
plot(df$datetime, df$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n",
     yaxt = "n", 
     ylim = c(-1,40))

lines(df$datetime, df$Sub_metering_2, col = "red")
lines(df$datetime, df$Sub_metering_3, col = "blue")

# Custom y-axis ONLY till 30
axis(2, at = seq(0, 30, by = 10))

axis(1,
     at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
     labels = c("Thu", "Fri", "Sat"))

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n")

# -----------------------
# Plot 4: Global Reactive Power
# -----------------------
plot(df$datetime, df$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global reactive power",
     xaxt = "n",
     yaxt = "n", 
     ylim = c(-0.01,0.51))

axis(2, at = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5))

axis(1,
     at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
     labels = c("Thu", "Fri", "Sat"))