str(iris)
set.seed(1234)
ind <- sample(2,nrow(iris),replace = T,prob=c(0.7,0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]
library(party)
myFormula <- Species~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width
iris_ctree <- ctree(myFormula,data=trainData)
table(predict(iris_ctree),trainData$Species)
plot(iris_ctree)
