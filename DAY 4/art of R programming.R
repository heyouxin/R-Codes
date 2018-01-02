hn <- hist(Nile)
print(hn)
summary(Nile)
 
class(Nile)
attributes(Nile)
View(Nile)

mtcars
fit <- lm(mpg~wt,data=mtcars)
attributes(fit)
class(fit)
fit
attributes(summary(fit))


k <- 0
n <- seq(1,6 ,by=2)
all(n<5)
for (i in n) {
  k <- k+1
  
#vector add  delete　重构一个ｖｅｃｔｏｒ
x <- c(1,2,3,4)
dim(x)
x <- c(x[1:2],x[4])
x


m1 <- matrix(c(1,2,3,4),nrow=2, byrow = F)
m1
dim(m1)
}


example("persp")
persp



#row.names not set , either insert more a column denote the row.names
#so,data.frame is actually a table
rowname <- c("n1","n2","n3")
name <- c("a","b","c")
age <- c(1,2,3)
d1 <- data.frame(name,age,row.names = rowname)
#d1 <- edit(d1)
View(d1)
dl <- lapply(d1, sort)
t1 <- table(name,age)
#t1 <- edit(t1)

#？把row.names取出来，当作data.frame的元素？
#？table的用法？


l <- list(c(1,2,3),c("a","b"))
l

table(c(5,12,13,12,8,5))


#手动修改元素
f1 <- c(1,2,2,3)
f2 <- edit(f1)
View(f2)


#引用function
source("sour.R")
plot(func,0,10)


D(expression(sin(x)*cos(x)) ,"x")
integrate(function(x) x,0,1)


mtcars
fit <- lm(mpg~wt,data=mtcars)
class(fit)
?getAnywhere


vec1 <- c(3,1,4,5)

# ?scan ?
s1 <- scan("11.txt")

w <- readline()
cat("aa","1","2a4",sep="\n")


name <- c("a","b","c")
advmic <- c(10,20,39)
advmac <- c(500,600,1000)
stu <- data.frame(name,advmic,advmac)
stu2 <- edit(stu)
View(stu2)



library(sqldf)

for (i in 1:10) {
  sql1 <- sqldf("insert stu values('d',1000,1000)","select * from stu")
  
}
View(sql1)






a <- c(1,2,3)
a <- as.character(a)
is.character(a)










