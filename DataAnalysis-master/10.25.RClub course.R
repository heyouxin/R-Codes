typeof(letters)
F+1+T
a <- c(T,1)
b <- as.character(a)
b
a
l <- list(1,"232")
typeof(l)
l


rm(vec)
vec <- 1:5
names(vec) <- rep("aa",5)
vec
vec <- 1:5
names(vec)
v <- c(2,323,54,23,566,19)
#v>=5
#v[which(v>=5)]
unique(v)
order(v)
sort(v)
#????rank(v)
fac <- factor(1,3,3,2)
fac
as.numeric(fac)
factor(letters[1:20], labels = "letters")

iris3
state.x77
typeof(cars)
data
library(foreign)
df <- data.frame(a=1,b=2,c="c")
df
write.dta(df,"C:/Users/heyouxin/Desktop/mydata.dta")

attach(df)
a
detach(df)
mtcars
?plot

with(mtcars,{
  lm(mpg~cyl)
  plot(x=mpg,y=cyl)})

str(iris)
head(iris)







10220+(4041*.36)+450*.04
1/30+1/160

6.4+9/80-1/200





(10000/625)^(1/4)




n <- c(1:300)
which((((.99)^n/gamma(n-1))*exp(-.99))>=.99)



which((choose(300,n)*(.99^(300-n))*(.01^n))>=.0001)

choose(300,1)*(.99^(300-1))*(.01^1)
    
.99^(300)


x <- 0
for (n in 0:300) {
  x <- x+(choose(300,n)*(.99^(300-n))*(.01^n))
  if(x>=.99) 
  {
    print(n) 
    break
  }
}

x <- 0
for (n in 0:300) {
  x <- x+(choose(300,n)*(.99^(300-n))*(.01^n))
  print(x)
}



