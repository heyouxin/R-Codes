library(xlsx)
library(ggplot2)
log_penalty <- read.xlsx("新建 Microsoft Excel 工作表 (2).xlsx",1,encoding="UTF-8")

View(log_penalty)
library(reshape2)
dfidfm <- melt(log_penalty, id.vars="平衡比例")
ggplot(dfidfm, aes(x=平衡比例, y=value))+ geom_line(aes(color=variable))


auc_total <- read.csv("auc_total.csv")
View(auc_total)
attach(auc_total)
auc_total$x <- as.double(auc_total$x)
ggplot(auc_total,aes(x=x))+
  geom_histogram(binwidth =.01 ,fill="lightblue",color="black")+
  labs(x = "AUC")

rf <- read.csv("file:///C:/Users/heyouxin/Documents/Tencent Files/277583393/FileRecv/res1.csv")
View(rf)
library(reshape2)
dfidfm <- melt(rf, id.vars="X")
ggplot(dfidfm, aes(x=X, y=value))+ geom_line(aes(color=variable))+labs(x = "平衡比例")


ggplot(dt, aes(x = obj, y = val, fill = obj, group = factor(1))) + 
  geom_bar(stat = "identity") +
  theme_economist()


rf_2 <- read.csv("file:///C:/Users/heyouxin/Desktop/import.csv")

barplot(rev(rf_2$X),horiz=T,xlim=c(-4,1),axes=F,col=rep(brewer.pal(9,'YlOrRd'),each=15))  
text(seq(from=0.7,length.out=135,by=1.2),x=-2,label=rev(rf_2$Feature.Importance))  
axis(3,c(0,0.25,0.5,0.75,1),c('0%','25%','50%','75%','100%'))  


ggplot(rf_2, aes(x=X) ) + geom_bar() + coord_flip()


rf_2$X <- as.integer(rownames(rf_2))
rf_2$
  
  
  
p1 <- ggplot(data = rf_2, aes(x=X,y=rf_2$Feature.Importance))

p1 <- p1 + geom_bar( stat="identity" , width = 0.5, fill = "cornflowerblue")

p1 + scale_x_continuous(breaks=Feature.Importance, labels=X, labels=df_report_1_toPPT2orderID, labels=df_report_1_toPPT2from_ent_level)

df_report_1_toPPT2$orderID <- as.integer(rownames(df_report_1_toPPT2))
p1 <- ggplot(data = df_report_1_toPPT2, aes(x=orderID,y=df_report_1_toPPT2$code_count))
p1 <- p1 + geom_bar( stat="identity" , width = 0.5, fill = "cornflowerblue")
p1 + scale_x_continuous(breaks=df_report_1_toPPT2orderID, labels=df_report_1_toPPT2orderID, labels=df_report_1_toPPT2orderID, labels=df_report_1_toPPT2from_ent_level)

