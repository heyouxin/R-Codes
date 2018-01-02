library(reshape2) 
raw <- read.csv("data/pew.csv", check.names = F) 
View(raw)
tidy <- melt(raw, id = "religion") 
View(tidy) 
# We can now fix the column names 
names(tidy) <- c("religion", "income", "n") 
View(tidy)
# Alternatively 
tidy <- melt(raw, id = "religion",variable.name = "income", value.name = "n") 
View(tidy)

titanic2 <-read.csv("data/titanic2.csv",stringsAsFactors = FALSE) 
head(titanic2)
# 计算不同类别的存活率 = 存活人数/（存活人数 + 死亡人数） 
#Step 1 
#total <- titanic2$male+titanic2$female
#View(total)
#titanic3 <- cbind(titanic2,total)
library(sqldf)
newdf<-sqldf("select *  from titanic2 group by class ,age,  fate",row.names=T)
class(newdf)
View(newdf)

c <- newdf$`sum(total)`
View(c[2]/(c[1]+c[2]))




titanic2 <-read.csv("data/titanic2.csv",stringsAsFactors = FALSE) 
head(titanic2)
# 计算不同类别的存活率 = 存活人数/（存活人数 + 死亡人数） 
#Step 1 
total <- titanic2$male+titanic2$female
View(total)
titanic3 <- cbind(titanic2,total)
library(sqldf)
newdf<-sqldf("select fate,sum(total) from titanic3 group by fate",row.names=T)
c <- newdf$`sum(total)`
View(c[2]/(c[1]+c[2]))


titanic2 <-read.csv("data/titanic2.csv",stringsAsFactors = FALSE) 
melt(titanic2)
# 计算不同类别的存活率 = 存活人数/（存活人数 + 死亡人数） 
#Step 1 
tidy <- melt(titanic2, id = c("class", "age", "fate"),variable.name = "gender") 
View(tidy) 
#Step 2 
tidy <- dcast(tidy, class + age + gender ~ fate,value.var = "value") 
head(tidy) 
#Step 3 
tidy$rate <- round(tidy$survived /(tidy$survived + tidy$perished), 2) 
head(tidy)




titanic2 <-read.csv("data/titanic2.csv",stringsAsFactors = FALSE) 
tyde <- melt(titanic2,id.vars = "class",)
head(tyde)


head(airquality)
 aq <- melt(airquality, var.ids=c("Ozone", "Month", "Day"), measure.vars=c(2:4), variable.name="V.type", value.name="value") 
head(aq)




airquality
summary(airquality)
plot(airquality$Ozone,airquality$Wind)


##repeat 结果  设置种子
set.seed(123)
x <- rnorm(10)
x <- rbeta(1,2)
y <- seq(1,12,2)
y
from <- as.Date("2016-10-24")
to <- as.Date("2016-10-31")
date <- seq(from,to,by="day")
date


s <- seq(1:6)
r <- rep(1:6,s)
r

paste0("x",1:6,collapse = ",")

x <- 1:10
y <- x[5]
y <- c(x[1],x[10])
y
y1 <- x[seq(1,10,2)]
y1

y2 <- x[seq(2,10,2)]
y2


y3 <- x[-c(1,8)]
y3

v1 <- c(1,5,6,3,4,8)

for (i in (length(v1)-1)) {
  t <- v1[i+1]-v1[i]
  print(t)
}



x <- c(1,5,6,3,4,8)
x>=3
x[x>=3]
x[which(x>=3)]



letters
LETTERS
paste0(LETTERS,letters)
sort(x,decreasing = T)


set.seed(123)
x <- sample(1:100,20,replace=T)
data <- data.frame(x)
library(sqldf)
newdf<-sqldf("select * from data where x>=21 and x<=55",row.names=T)
newdf

which(x>50)
x[which(x>50)]

u<-c(5,2,8)
v<-c(1,3,9)
u[which(u>v)] <- NA
u

options(digits=3)
set.seed(123)
x <- sample(c(1:100,rep(NA,100)),100,replace=T)
y <- mean(x[-which(is.na(x))])
x[which(is.na(x))] <- y
x




