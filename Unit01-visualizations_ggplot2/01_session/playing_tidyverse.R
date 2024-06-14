# Working with survey data in Tidyverse

# install packages and load libraries
install.packages("tidyverse")  
library(tidyverse)

# load data file from website
download.file(url = "https://zenodo.org/record/6478181/files/ceramics_data.csv?download=1", destfile = "data_raw/ceramics_data.csv")
read_csv("data_raw/ceramics_data.csv")

# define variables
surveys = read_csv("data_raw/ceramics_data.csv")
surveys <- read_csv("data_raw/ceramics_data.csv")
head(surveys)
surveys_sample <- head(surveys, 100)
surveys_end_sample <- tail(surveys, 100)
view(surveys)
view(surveys_sample)
view(surveys_end_sample)

# convert column data to factors
str(surveys)
surveys$diagnostic
surveys$diagnostic <- factor(surveys$diagnostic)
summary(surveys$diagnostic)
diagnostic <- factor(c("rim", "base", "base", "rim"))
levels(diagnostic)
nlevels(diagnostic)

diagnostic # current order
diagnostic <- factor(diagnostic, levels = c("rim", "base"))
diagnostic # after re-ordering

# Exercise: convert manufacture_technique and decoration_type to factors
surveys$manufacture_technique
surveys$manufacture_technique <- factor(surveys$manufacture_technique)
summary(surveys$manufacture_technique)
nlevels(surveys$manufacture_technique)
surveys$decoration_type
surveys$decoration_type <- factor(surveys$decoration_type)
summary(surveys$decoration_type)
nlevels(surveys$decoration_type)

# Converting factors
as.character(diagnostic)

year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct) # wrong! but no warning...
as.numeric(as.character(year_fct)) # now it works
as.numeric(levels(year_fct))[year_fct] # recommended method

## bar plot of the number of artefacts diagnosed by rim and base
plot(surveys$diagnostic)

# add NA vaules to plot
diagnostic <- surveys$diagnostic
levels(diagnostic)
diagnostic <- addNA(diagnostic)
levels(diagnostic)
head(diagnostic)
levels(diagnostic)[3] <- "Unknown"
levels(diagnostic)
plot(diagnostic)

# Exercise
levels(diagnostic)[1] <- "Base"
levels(diagnostic)[2] <- "Rim"
levels(diagnostic)[1:2] <- c("Base", "Rim")
levels(diagnostic)
plot(diagnostic)

# re-order factors
diagnostic <- factor(diagnostic, levels = c("Unknown", "Base", "Rim"))
levels(diagnostic)
plot(diagnostic)
