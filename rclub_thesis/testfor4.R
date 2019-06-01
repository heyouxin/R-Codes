library(arules)  #加载 arules 包
library(arulesViz)
data = read.transactions('datafor4.txt',format="single",sep='\t',cols=c(1,2),rm.duplicates=TRUE)
inspect(data[1:5])

set.seed(12)
n= dim(data)[1]
index = sample(n*0.7,replace=FALSE)
train = data[index]
test = data[-index]

summary(train)

# way1 整体关联
rules <- apriori(data = train,parameter = list(support = 0.008,confidence = 0.15,minlen = 2))

summary(rules)

## lift排序之后的规则
inspect(sort(rules,by="lift")[1:10])


subrules <- subset(rules,items %in% "妇女权益")  # items 表明与出现在规则的任何位置的项进行匹配，为了将子集限制到匹配只发生在左侧或者右侧位置上，可以使用lhs或者rhs代替
subrules
inspect(subrules[1:2])


plot(rules, measure = c("support", "lift"), shading = "confidence")
plot(x=subrules,method="graph")

#  检验参考 https://blog.csdn.net/yepeng2007fei/article/details/78910105
##此行报错，先检验train
qualityMeasures <- interestMeasure(rules, method=c("coverage","fishersExactTest","conviction"), transactions=train) 
summary(qualityMeasures) 
quality(groceryrules) <- cbind(quality(rules), qualityMeasures)  
inspect(head(sort(rules, by = "conviction", decreasing = F)))  



