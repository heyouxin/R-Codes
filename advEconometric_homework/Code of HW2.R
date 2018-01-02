#Read data from consumption.data and pretreatment----------------------------------
consumption_data <- read.table(file = "D:/R/XT/Homework_2/data.txt")
consumption_data <- consumption_data[, - 1]
colnames(consumption_data) <- c("Year", "quarter", "YD", "CE")
consumption_data[, 3:4] <- log(consumption_data[, 3:4])
#===================================================================================
#Run the first regression of function (1)------------------------------------------
#===================================================================================
library("car")
attach(consumption_data)
reg_data1 <- data.frame(CE = CE[-1], CE_lag = CE[-200], YD = YD[-1], YD_lag = YD[-200])
reg_lm1 <- lm(CE~., data = reg_data)
summary(reg_lm1)
linearHypothesis(reg_lm1, "YD + YD_lag = 0")
#Under the 95% confidenct level, we could not reject the null hypothesis--------------
#Another method to test null hypothesis of "gamma0 + gamma1 = 0"
reg_data2 <- data.frame(CE = CE[-1], CE_lag = CE[-200], Delta_YD = diff(YD), YD_lag = YD[-200])
reg_lm2 <- lm(CE~., data = reg_data2)
summary(reg_lm2)  #Just check the significance of YD_lag
#======================================================================================
#Run the second regression of function (2)--------------------------------------------
#======================================================================================
reg_data3 <- data.frame(Delta_CE = diff(CE), CE_lag = CE[-200], Delta_YD = diff(YD), YD_lag = YD[-200])
reg_lm3 <- lm(Delta_CE~., data = reg_data3)
coef2 <- reg_lm3$coefficients
new_coefficients <- c(coef2[1], 1 + coef2[2], coef2[3], coef2[4] - coef2[3])
names(new_coefficients) <- c("alpha", "beta", "gamma0", "gamma1")
new_coefficients
detach(consumption_data)