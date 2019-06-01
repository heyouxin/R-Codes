library(InformationValue)
library(plyr)
library(smbinning)
data <- read.csv("test_data.csv")
data <- data[,-1]
##R包里 负例是0，正例是1  ！！！
data$isdefault <- 1
data[data$default==1,'isdefault'] <- 0
IV(X=as.factor(data[,"industry_name"]),Y=as.factor(data[,"isdefault"]))
WOETable(X=as.factor(data[,"industry_name"]),Y=as.factor(data[,"isdefault"]))
assign(paste("iv_table_","industry_name",sep=""),ddply(data,c("industry_name"),summarise,N=length(default),Good=length(default)-sum(default),Bad=sum(default),Good_pct=(length(default)-sum(default))/length(default),Bad_pct=sum(default)/length(default)))
a <- get(paste("iv_table_","industry_name",sep=""))
assign(paste("iv_table_","industry_name",sep=""),a[order(-a$Bad_pct),])
print(get(paste("iv_table_","industry_name",sep="")))

data$industry_name_seg <- ifelse(data$industry_name %in% c("制造业","采矿业","建筑业"),1,
                                 ifelse(data$industry_name %in% c("交通运输、仓储和邮政业","电力、热力、燃气及水生产和供应业","综合"),2,
ifelse(data$industry_name %in% c("房地产业","金融业","农、林、牧、渔业","批发和零售业","卫生和社会工作","文化、体育和娱乐业","信息传输、软件和信息技术服务业","住宿和餐饮业"),3,4)))
WOETable(X=as.factor(data$industry_name_seg),Y=as.factor(data$default))
IV(X=as.factor(data$industry_name_seg),Y=as.factor(data$default))

data$industry_name_WOE <- WOE(as.factor(data$industry_name_seg),as.factor(data$default))
data$industry_name_coutpoint <- as.character(data$industry_name_seg)

data_WOE <- data.frame("default"=data$default,"industry"=data$industry_name_WOE)
data_WOE$default <- data$default
data_WOE$industry_WOE <- data$industry_name_WOE

#定量指标
quant_vars <- setdiff(colnames(data),c("industry_name","industry_name_seg","industry_name_WOE","industry_name_coutpoint"))
quant_kb <- data[,quant_vars]
quant_kb$isdefault <- 1
quant_kb[quant_kb$default==1,'isdefault'] <- 0

ivs <- c()
vars <- c()
index <- c()


#最优分箱
for (i in 2:(ncol(quant_kb)-1)) 
{
  assign(paste("result_",colnames(quant_kb)[i],sep=""),
         smbinning(df=quant_kb,y='isdefault',x=colnames(quant_kb)[i],p=0.05))
  result <- get(paste("result_",colnames(quant_kb)[i],sep=""))
  #if (T)
  if( (result[1]!="uniques values of x<10") & (result[1]!="No significant splits"))
  {
    index <- c(index,i)
    vars <- c(vars,result$x)
    ivs <- c(ivs,result$iv)
  }
  
}
quant_ivs <- as.data.frame(cbind(index,vars,ivs))
quant_ivs_sort <- quant_ivs[order(quant_ivs$ivs,decreasing=T),]
head(quant_ivs_sort,20)
result_saleat_mean
saleat_mean_cutpoint <- c()
saleat_mean_woe <- c()
saleat_mean <- quant_kb[,"saleat_mean"]
for (i in 1:length(saleat_mean)) 
{
  
  if(is.na(saleat_mean[i]))
  {
    saleat_mean_cutpoint[i] <- "NA"
    saleat_mean_woe[i] <- -1.1415
    
  }
  else
  {
    if(saleat_mean[i]<=0.0176)
  
    {
  
      saleat_mean_cutpoint[i] <- "<=0.0176"
    
      saleat_mean_woe[i] <- -1.0493
  
    }
    if(saleat_mean[i]<=0.0576 & saleat_mean[i]>0.0176)
      
    {
      
      saleat_mean_cutpoint[i] <- "<=0.0576"
      
      saleat_mean_woe[i] <- 3.3916
      
    }
    if(saleat_mean[i]<=0.0892)
      
    {
      
      saleat_mean_cutpoint[i] <- "<=0.0892"
      
      saleat_mean_woe[i] <- 0.1297
      
    }
    if(saleat_mean[i]> 0.0892)
      
    {
      
      saleat_mean_cutpoint[i] <- ">0.0892"
      
      saleat_mean_woe[i] <- -1.1415
      
    }
  }
  
}

model_data_WOE <- data.frame(quant_kb["isdefault"],"saleat_mean_woe"=saleat_mean_woe)
logr <- glm(isdefault~.,data=model_data_WOE,family = binomial)
predicted_ori <- predict(logr,type = 'response')
summary(logr)
#library(pROC)
alpha_beta <- function(basepoints,baseodds,pdo)
{
  beta <- pdo/log(2)
  alpha <- basepoints+beta*log(baseodds)
  return(list(alpha=alpha,beta=beta))
}
x <- alpha_beta(600,1,20)
x
cof <- logr$coefficients
basepoin <- round(x$alpha-x$beta*cof[1],1)
basepoin

#输出评分卡
r1 <- c("intercept",600,basepoin)
scorecard_output <- matrix(r1,nrow = 1)
for (i in 2:ncol(model_data_WOE)) 
{
  assign(paste(strsplit(colnames(model_data_WOE)[i],"_WOE")[[1]],"score",sep = "_"),
         round(as.matrix(-(as.numeric(model_data_WOE[[i]])*
                             cof[colnames(model_data_WOE)[i]]*x$beta)),1))
  
  assign(paste(strsplit(colnames(model_data_WOE)[i],"_WOE")[[1]],"scoreCard",sep = "_"),
         cbind(
           c(strsplit(colnames(model_data_WOE)[i],"_WOE")[[1]]),unique(
         cbind(
             get(paste(strsplit(colnames(model_data_WOE)[i],"_WOE")[[1]],"cutpoint",sep = "_")),
             get(paste(strsplit(colnames(model_data_WOE)[i],"_WOE")[[1]],"score",sep = "_"))
           )
         )
         ))




  scorecard_output <- rbind(scorecard_output,paste(get(strsplit(colnames(model_data_WOE)[i],"_WOE")[[1]],"scoreCard",sep = "_")))
         
}

predited1 <- x$alpha-x$beta*log(predicted_ori/(1-predited_ori))

score_foreach <- matrix(nrow=nrow(model_data_WOE),ncol = ncol(model_data_WOE))


for (j in 2:ncol(model_data_WOE)) 
{
  
  #model_data_WOE[[j]]*cof[colnames(model_data_WOE)[j]]*x$beta
  assign(paste(strsplit(colnames(model_data_WOE)[j],"_woe")[[1]],"score",sep = "_"),
         round(as.matrix(-(model_data_WOE[[j]]*cof[colnames(model_data_WOE)[j]]*x$beta)),1))
  
  score_foreach[,j] <- get(paste(strsplit(colnames(model_data_WOE)[j],"_woe")[[1]],"score",sep="_"))
  
  
  
}

score_foreach <- as.data.frame(score_foreach)

score_foreach['is_default'] <- data_WOE$default

