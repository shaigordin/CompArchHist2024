# statistical methods for archaeology: statistical exploration

## install packages and load libraries
install.packages("tidyverse")  
library(tidyverse)

## load data file from github
download.file(url = "https://martinhinz.github.io/smada2021/03_session/muensingen_fib.csv", destfile = "data_raw/muensingen_fib.csv")
muensingen <- read.csv2("data_raw/muensingen_fib.csv") # read fibulae datafile
head(muensingen)

## הצלבת נתונים לתוך טבלה חדשה
my_table <- table(muensingen$fibula_scheme, muensingen$Grave)
my_table
addmargins(my_table)

## גרפים של הנתונים של מונזינגן
plot(muensingen$Length)
plot(muensingen$Length, type = "b")
plot(as.factor(muensingen$fibula_scheme))

plot(muensingen$Length, muensingen$FL,
     xlim = c(0, 140), # הגבלה של ציר האיקס
     ylim = c(0, 100), # הגבלה של ציר הוואי
     xlab = "Fibula Length",
     ylab = "Foot Length",
     main = "Fibual Total Length vs. Foot Length",
     sub = "Example Plot")



