
library(tidyverse)

data <- as.data.frame(household_power_consumption)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
df <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

df$datetime <- strptime(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")


df$Global_active_power <- as.numeric(df$Global_active_power)

gap <- na.omit(df$Global_active_power)


par(yaxs = "i")   

hist(gap,
     breaks = 12,
     col = "red",
     border = "black",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     ylim = c(0, 1200),
     yaxt = "n")

axis(2, at = seq(0, 1200, 200))