library(quantmod)
library(reshape2)



diagnosis <- read.csv("diagnosis.csv")
diagnosis <- cbind(diagnosis, Disease="diagnosis")
datacollection <- read.csv("datacollection.csv")
datacollection <- cbind(datacollection, "Gas"="datacollection")
diagnosis_df <- data.frame(rbind(diagnosis, datacollection))
##write.csv(diagnosis_df, "diagnosis.csv", row.names=FALSE)

