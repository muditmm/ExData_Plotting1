
getwd()
setwd("C:/R/Coursera/04_ExploratoryAnalysis/Week1/")


library(dplyr)
library(tidyr)

### Data Extraction
HPC <- read.table("C:/R/Coursera/04_ExploratoryAnalysis/Week1/household_power_consumption.txt",
                sep = ";", header = TRUE)

## Filter data to two days in February
HPC1 <- HPC %>% filter (Date == "1/2/2007"| Date == "2/2/2007")
## Convert global active power to numeric
HPC1$Global_active_power <- as.numeric(HPC1$Global_active_power)
head(HPC1)

## separate day , month and year in separate fields
HPC1 <- HPC1 %>% separate(Date, c("d","m","y"))
## add 0 in front of day and month
HPC1$d <- paste("0", HPC1$d, sep = "")
HPC1$m <- paste("0", HPC1$m, sep = "")
## unite year month and day
HPC1 <- HPC1 %>% unite (DateTime, y,m,d, sep = "-")
## unite ymd and time
HPC1 <- HPC1 %>% unite (DateTime1, DateTime, Time, sep = " ")
## change the format for date
HPC1$DateTime1 <- strptime(HPC1$DateTime1, "%Y-%m-%d %H:%M:%S")

## create a plot


with (HPC1, plot(DateTime1, Global_active_power, type = "l", xlab = "", 
                 ylab = "Global Active Power (kilowatts)"))


## save the plot in local repository
setwd("C:/R/Coursera/04_ExploratoryAnalysis/Week1/Project/ExData_Plotting1")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()

