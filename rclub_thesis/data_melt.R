library(xlsx)
library(reshape2)
#data1 <- read.csv("data1.csv")
data <- read.xlsx("数据筛选.xlsx",1,encoding = "UTF-8")
#data2 <- stack(data1[,5:26])
data1 <- data[,c(1,2,3,4,seq(5,26,2))][,-15]
data2 <- data[,c(1,2,3,4,seq(6,26,2))][,-15]
colnames(data1)[5:14] <- c(1:10)
colnames(data2)[5:14] <- c(1:10)
data1 <- melt(data1,id.vars = c("No","Treated","classify","edu"),variable.name = "Time",value.name = "Stock_con")
data2 <- melt(data2,id.vars = c("No","Treated","classify","edu"),variable.name = "Time",value.name = "Trade_exp")

data_all <- merge(data1,data2)

data_all[,'Year'] <- 0
data_all[as.integer(data_all[,'Time'])>5,'Year'] <- 1



data <- read.xlsx("数据筛选.xlsx",2,encoding = "UTF-8")
#data2 <- stack(data1[,5:26])
data1 <- data[,c(1,2,3,4,seq(5,26,2))][,-15]
data2 <- data[,c(1,2,3,4,seq(6,26,2))][,-15]
colnames(data1)[5:14] <- c(1:10)
colnames(data2)[5:14] <- c(1:10)
data1 <- melt(data1,id.vars = c("No","Treated","classify","edu"),variable.name = "Time",value.name = "Stock_con")
data2 <- melt(data2,id.vars = c("No","Treated","classify","edu"),variable.name = "Time",value.name = "Trade_exp")

data_all_2 <- merge(data1,data2)

data_all_2[,'Year'] <- 0
data_all_2[as.integer(data_all_2[,'Time'])>5,'Year'] <- 1

data_all <- rbind(data_all,data_all_2)

write.xlsx(data_all,"data_reg_DID.xlsx")


data <- read.xlsx("数据筛选.xlsx",3,encoding = "UTF-8")
data1 <- data[,c(1,2,3,seq(4,23,2))]
data2 <- data[,c(1,2,3,seq(5,23,2))]
colnames(data1)[4:13] <- c(1:10)
colnames(data2)[4:13] <- c(1:10)
data1 <- melt(data1,id.vars = c("No","Treated","classify"),variable.name = "Time",value.name = "WBBL")
data2 <- melt(data2,id.vars = c("No","Treated","classify"),variable.name = "Time",value.name = "Trade_exp")

data_all_3 <- merge(data1,data2)

data_all_3[,'Year'] <- 0
data_all_3[as.integer(data_all_3[,'Time'])>5,'Year'] <- 1

data_all_panal <- merge(data_all_2,data_all_3)
write.xlsx(data_all_panal,"data_reg_panal.xlsx")

