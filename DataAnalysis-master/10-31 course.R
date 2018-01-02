a <-c(1,2,NA,4)
a<-a[!is.na(a)]
a<-na.omit(a)
a

rm(token)
b<-sample(1:100,50,replace = T)
y <- c(1,0,0,1,1,1,1,1)
#y <- y[-1]
#y
token <- 0
for (i in 1:length(y))
{
  if((y[i]==1)&&(y[i+1]==1)&&(y[i+2]==1)) 
    {token<-token+1}
  y <- y[-1]
}
token




x<- c(3,2,6,1,7,1,1)
which(x==1)[1]

x<-sample(1:100,50,replace = T)
y<-ifelse(x%%2==0,0,1)



a1<-c(1,3,4,5,6)
a2<-c(1,3,7,8,7)
ifelse(which(a1==a2),a1)
identical(a1,a2)




letters
names(letters)<-c(letters[-1],"a")
names(letters)



x1<-c(5,7,3,6,9,10,12)
n<-length(x1)
y1<-x[-1]-x[-n]
y1

y1<-diff(x1)
y1<-ifelse(y1>0,1,0)
y1
x2<-c(5555,17,33,43,3,39,34)
y2<-diff(x2)
y2<-ifelse(y2>0,1,0)
y2


length(which(ifelse(diff(x1)>0,1,0)
==ifelse(diff(x2)>0,1,0)))==length(y2)

mean(sign(diff(x1)))==mean(sign(diff(x2)))












match(a1,5)



















for (i in 1:length(x)) {
  if(x[i]%%2==1)
    {x[i]=1}
  else
    {x[i]=0}
  
}
x



  


