x <- sample(1:100,50,replace = T)
quantile(x,seq(0,1,0.1))
boxplot(x)
 

y <- "addfdfd1232"
 grep("df",y)
 

x <- c(1,3,5,7,2,9,11)
y <- c(3,9,11)
for (n in 1:length(y)) 
{
  z <- grep(y[n],x)
  print(z)
}
##which(x %in% y)
###去掉字符中空格 
library(stringr)
wtrmws()


###打印错误日志
###cat


x <- c(1:10)
for (i in x)
{
  print(x[i])  
  cat(x,file = "22.txt")
}


y<-NULL
for (i in 1:10)
{
  y<-paste(y,i," ")
  
  
}
print(y)
cat(y,file = "11.txt")


set.seed(1014)
df<-data.frame(replicate(6,sample(c(1:10,-99),6,rep=T)))
names(df) <- letters[1:6]
df
###S1
for (i in 1:6) 
{
  df[,i][which(df[,i]==-99)]<-NA
  
}
df
###

###S2
f1 <- function(x)
{
  x[x==-99]<-NA
  return(x)
  
}
for (i in 1:6) 
{
  df[,i]<-f1(df[,i])
  
}
df
###


###S3
df[]<-lapply(df, f1)
df
###


lapply(df,mean)
funs <- c(mean,sd)
lapply(funs, function(f) f())

tryCatch()
tryCatch(1, finally = print("Hello"))


df$e[which(df$e==-99)]<-NA
df$a[which(df$a==-99)]<-NA
df$b[which(df$b==-99)]<-NA



tryCatch(which(df$e==-99), finally = print("Hello"))
e <- simpleError("test error")
## Not run: 
stop(e)
tryCatch(stop(e), finally = print("Hello"))
tryCatch(stop("fred"), finally = print("Hello"))





