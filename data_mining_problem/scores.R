library(xlsx)
library(ggplot2)
scores <- read.xlsx("成绩汇总.xlsx",1,encoding = "UTF-8",stringsAsFactors=FALSE)
#View(scores)
attach(scores)
scores$成绩 <- as.integer(scores$成绩)
ggplot(scores,aes(x=成绩))+
  geom_histogram(binwidth = 10,fill="lightblue",color="black")


boxplot(scores$成绩)

mean(scores$成绩)
median(scores$成绩)
max(scores$成绩)
min(scores$成绩)




scores_3 <- scores[scores$班级==3,]
View(scores_3)
write.csv(scores_3,"class3.csv")

library(xlsx)
scores_3 <- read.xlsx("class3.xlsx",1,encoding = "UTF-8")
View(scores_3)
scores_3$学号_2 <- as.character(scores_3$学号) 
scores_3$学号_2 <- substr(scores_3$学号_2,11,14)

write.xlsx(scores_3[,7:8],"class3.xlsx")
