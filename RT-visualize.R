# playing around with ritual text data

rt <- read.csv2("data_raw/RT.csv")
rt

collection <- as.factor(rt$Collection)
plot(collection)
