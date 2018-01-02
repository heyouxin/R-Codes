rm(list=ls())
#library(openxlsx)
library(xlsx)
library(stringr)
library(splitstackshape)
filename<-"./advEconometric_homework_files/consumption_data.xlsx"
raw_data<-read.xlsx(filename,sheetName = 1,encoding = "UTF-8")

#获取列名
col_name<-names(raw_data)

#按“空格”符号分割表内数据
data<-cSplit(raw_data,col_name," ")
#View(data)

#重命令列名
names(data)<-c("OBS","year","quarter","YD","CE")
#View(data)

#y_q <- paste0(data$year,"-0",data$quarter)
#y_q <- as.character.Date(y_q)
log_c <- log(data$CE)
log_c_1 <- c()
log_c_1[2:200] <- log_c[1:199]
log_c_1[1] <- NA
log_y <- log(data$YD)
log_y_1 <- c()
log_y_1[2:200] <- log_y[1:199]
log_y_1[1] <- NA

data <- cbind(data,log_c)
data <- cbind(data,log_y)
data <- cbind(data,log_c_1)
data <- cbind(data,log_y_1)

delta_c <- c()
delta_y <- c()
delta_c[2:200] <- diff(log_c)
delta_c[1] <- NA
delta_y[2:200] <- diff(log_y)
delta_y[1] <- NA
data <- cbind(data,delta_c)
data <- cbind(data,delta_y)


#View(data)
data_regression <- data[-c(1:24),]
#View(data_regression)

fit1 <- lm(log_c~log_c_1+log_y+delta_y,data = data_regression)
summary(fit1)
#we can change the regressor so that gamma_0+gamma_1 
#is equal to the coefficient of log_y
#t value = 1.749   not reject the null
fit2 <- lm(delta_c~log_c_1+delta_y+log_y_1)
summary(fit2)
fit3 <- lm(log_c~log_c_1+log_y+log_y_1)
summary(fit3)
#write.xlsx(data,"./advEconometric_homework_files/data_adjusted.xlsx",row.names = F)
