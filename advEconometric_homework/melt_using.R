
library(xlsx)
library(reshape2)
EDINEQ<-read.xlsx("C:\\Users\\heyouxin\\Desktop\\EDINEQ.xlsx",header=T,1,encoding = "UTF-8")
EDINEQ <- na.omit(EDINEQ)
EDINEQ <- EDINEQ[-20,]

GR<-read.xlsx("C:\\Users\\heyouxin\\Desktop\\GR.xlsx",header=T,1,encoding="UTF-8")
GR <- na.omit(GR)
GR <- GR[-20,]

EDINEQ<-melt(EDINEQ,id.vars='年份',variable.name='省份',value.name='EDINEQ')
EDINEQ$省份 <- substr(EDINEQ$省份,4,5)
View(EDINEQ)

GR<-melt(GR,id.vars='年份',variable.name='省份',value.name='GR')
View(GR)
                                                                 