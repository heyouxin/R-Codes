data <- read.delim2("data_zl.txt",header = F)
head(data)
class(data)
class(data$V1)
data1<-as.character(data$V1)
data1[2]
length(data1)
head(data1)
class(data1)
data1[14]
data[which(is.null(data$V1))]
data1 <- strsplit(as.character(data$V1),"<REC>")
data1[42]
