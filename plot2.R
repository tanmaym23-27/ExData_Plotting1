library(tidyverse)

data <- as.data.frame(household_power_consumption)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
df <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

df$datetime <- strptime(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")

df$Global_active_power <- as.numeric(df$Global_active_power)

gap <- na.omit(df$Global_active_power)

# Ensure correct format
df$datetime <- as.POSIXct(df$datetime)


par(yaxs = "i")   # IMPORTANT: removes padding

plot(df$datetime,
     df$Global_active_power,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n",
     yaxt = "n",
     ylim = c(0, 8))   # ensure 0 is included

# Y-axis with 0 included
axis(2, at = c(0, 2, 4, 6))

# X-axis (unchanged)
axis(1,
     at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
     labels = c("Thu", "Fri", "Sat"))