# Working with survey data in Tidyverse

install.packages("tidyverse")  
library(tidyverse)
download.file(url = "https://zenodo.org/record/6478181/files/ceramics_data.csv?download=1", destfile = "data_raw/ceramics_data.csv")
download.file(url = "https://zenodo.org/record/6478181/files/ceramics_data.csv?download=1",
              destfile = "data_raw/ceramics_data.csv")
read_csv("data_raw/ceramics_data.csv")
surveys = read_csv("data_raw/ceramics_data.csv")
surveys <- read_csv("data_raw/ceramics_data.csv")
