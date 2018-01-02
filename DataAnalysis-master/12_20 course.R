#load library
library(haven)
library(lubridate)

##分组回归
library(lme4)
library(dplyr)
  


df.raw<-read_sas("data/stockreturn.sas7bdat")
df<-df.raw
df$DATE<-as.Date(df$DATE, origin="1960-01-01")
df$YEAR<-year(df$DATE)
df$MONTH<-month(df$DATE)#duplicate month problem
head(df)
df2<-subset(df,YEAR>1926 & YEAR<1929,select = c(PERMNO,DATE,YEAR,MONTH,RET,EWRETD))
attach(df2)
lm1 <-lmList(RET~EWRETD | PERMNO,df2)
head(lm1)
write.txt(lm1,"fit.txt")

lm1[3]



reg1<-function()
{
  fit<-lm(group$RET~group$EWRETD)
  return (fit)
}
group <- df2 %>% group_by(PERMNO) %>% lapply(df2, reg1)
#reg1(group)
group
lapply(group, reg1)


