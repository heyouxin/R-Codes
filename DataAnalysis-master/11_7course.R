library(sqldf)



df <- as.data.frame(replicate(10,sample(1:100,50,replace = T)))
df <- df/lapply(df,mean)
df


column_name <- paste0("x",1:10)
names(df) <- column_name
c1 <- c(1,3,5,7,10,11,12,13,14,15)
c2 <- c(2,4,6,8,10)
df[c1,]
df[,c2]
y<- apply(df,2,var)
y
df2 <- df[,paste0("x",seq(2,10,2))]
df2

length(unique(df$x1))
df<-cbind(df,y)
df

#JOIN 2 dataframe
#Inner join  A intersect B 
# left outjoin A intersect B + A    right outjoin         full outjoin


score1 <- data.frame(NO=c(1,2,3,4,7),SCOREA=c(60,70,80,50,40))
score2 <- data.frame(NO=c(1,2,3,5,8),SCOREB=c(90,80,70,60,50))
score3 <- subset(score1,SCOREA>60 & SCOREA<80)
score3
#cbind(score1,score2)

total<-merge(score1,score2)
total





x
library(sqldf)
sql_df <- sqldf(c("select * from df where x1>=50 and x2<=50"))
sql_df


df2 <- data.frame(x1,x2,x4,x8,x10)




sql_df <- sqldf(c("select * from df where v1==100"))






m<-mtcars
m
names(mtcars)


library(sqldf)
sql_df <- sqldf(c("select cyl, avg(hp) avg_hp from m group by cyl "))
sql_df
boxplot(hp~cyl,data=m)
sql_df2 <-sqldf(c("select *,avg(mpg) from m group by cyl "))
sql_df2

m&cyl<-factor(m$cyl)
res2<-tapply(m$mpg, in, function)



