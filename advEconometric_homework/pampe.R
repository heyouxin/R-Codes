rm(list=ls())
rgrowth <- read.csv("growth.csv")
View(rgrowth)
rgrowth_2 <- as.matrix(rgrowth)
library("Formula")
library("plm")
library("leaps")
library("pampe")
time.pretr<-c("1975-Q1","1979-Q4")
time.tr<-c("1984-Q1","1988-Q4")
treated<-"SOUTHAFRICA"
controls<-"KOREA, DENMARK,CANADA,FINLAND,NETHERLANDS,MEXICO,ITALY,IRELAND,SWITERLAND,GREECE"
summary(rgrowth)
econ.integ<-pampe(time.pretr = 1:5,time.tr = 6:10,treated = treated, data = rgrowth)
