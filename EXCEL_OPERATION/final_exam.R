library(splitstackshape)
library(dplyr)
library(sqldf)

####step 1 清洗数据
stu_data<-read.csv("survey2014_student.csv",col.names = )
head(stu_data)
#获取列名，按“.”符号分割列名
col_name<-names(stu_data)
col_name<-unlist(strsplit(col_name,"[.]"))

#按“;”符号分割表内数据
stu_data<-cSplit(stu_data,"no.sex.high.weight.father.mother",";")
View(stu_data)

#重命令列名
names(stu_data)<-col_name
View(stu_data)


#处理缺失值 去除含有 NA的行 存储到newdata变量中
newdata<-na.omit(stu_data)



#清除异常数据 身高大于300，体重大于1000
newdata<-filter(newdata,(100<high) & (high<300))
newdata<-filter(newdata,(100<father) &(father<300))
newdata<-filter(newdata,(100<mother) &(mother<300))
newdata<-filter(newdata,(80<weight) &(weight<500))
head(newdata)
View(newdata)

####以上清洗数据完成


#step 2 建立模型

#更改变量sex为二元变量，男=1，女=0
attach(newdata)
sql1<-sqldf(c("update newdata set sex=1 where sex='男'","update newdata set sex=0 where sex='女'","select * from newdata"))
detach(newdata)
newdata<-sql1


#身高对性别 、 体重、父亲身高、母亲身高作回归
fit<-lm(high~sex+weight+father+mother,newdata)
summary(fit)
par(mfrow=c(2,2))
plot(fit)

friends_data<-read.csv("survey_friends.csv")
friends_data$sex<-as.factor(friends_data$sex)

predict_height<-predict(fit,friends_data)
friends_data$high

fit2<-lm(predict_height~friends_data$high)
plot(predict_height,friends_data$high)
abline(fit2)
# #分割数据
# str_func<-function(x)
# {
#   unlist(strsplit(as.character(x),"[;]"))
#   
# }
# #得到分割好的数据，类型为List
# data<-lapply(stu_data[,1], str_func)
# 
# #剔除只有5个元素的行
# for(i in 1:length(data))
# {
#   if(lengths(data[i])!=6)
#   {
#     data<-data[-i]
#   }
# }