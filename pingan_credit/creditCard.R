rm(list=ls())
###

### 第一版债券违约预警评分卡模型    hyx    2018.7.25

###
library(smbinning)
library(InformationValue) #这个包有疑问 当全为好样本的时候，坏样本数量也为全部，这样计算避免Inf
#library(sampling)
data <- read.csv("final_All_Data_0719_2.csv")

## 0是违约  1是不违约
data$isdefault <- 1
data[data$is_default==1,'isdefault'] <- 0

#目前因子不多，手动筛选因子
data <- data[,c('code','isdefault','CPI','ChinaNewsBasedEPU','GDP','alpha','belta','belta_yj','belta_yz','consumption','creditspread','finance_1','finance_2','finance_3','finance_4','finance_5','finance_6','finance_7','finance_8','finance_9','finance_10','finance_11','finance_12','finance_13','finance_14','finance_15','listed','bond_type_wind_1','company_type','exchange','industry','province','is_default')]
data <- na.omit(data)

#train$ID_unit
train <- strata(data,"isdefault",size=c(0.75*nrow(data[data$is_default==0,]),0.75*nrow(data[data$is_default==1,])),"srswor")
###分层抽样，划分训练集、测试集
# row_default <- sample(data[data$is_default==1,],nrow(data[data$is_default==1,])*0.75,replace = F)  
# row_Ndefault <- sample(nrow(data[data$is_default==0,]),nrow(data[data$is_default==0,])*0.75,replace = F)  
# row_train <- c(row_default,row_Ndefault)
X_train <- na.omit(data[train$ID_unit,])
y_train <- data[train$ID_unit,"isdefault"]

X_test <- data[-train$ID_unit,]
y_test <- data[-train$ID_unit,'isdefault']

##var_factor 
var_factor <- c('listed','bond_type_wind_1','company_type','exchange','industry','province')
smbinning.eda(X_train)
#result <- smbinning.factor(X_train,x="company_type",y="isdefault",C("''"))
result$ivtable
X_train$listed_woe <- WOE(as.factor(X_train$listed),as.factor(X_train$isdefault))
X_train$bond_type_wind_1_woe <- WOE(as.factor(X_train$bond_type_wind_1),as.factor(X_train$isdefault))
X_train$company_type_woe <- WOE(as.factor(X_train$company_type),as.factor(X_train$isdefault))
X_train$exchange_woe <- WOE(as.factor(X_train$exchange),as.factor(X_train$isdefault))
X_train$industry_woe <- WOE(as.factor(X_train$industry),as.factor(X_train$isdefault))
X_train$province_woe <- WOE(as.factor(X_train$province),as.factor(X_train$isdefault))

woe_table_factor <- X_train[,c('is_default','listed_woe','bond_type_wind_1_woe','company_type_woe','exchange_woe','industry_woe','province_woe')]

for (f in var_factor)
{
  
  assign(paste0("woetable_",f),WOETable(as.factor(X_train[,f]),as.factor(X_train$isdefault)))

}
View(woetable_industry)
sum(woetable_industry$GOODS)
sum(woetable_industry$BADS)

#定量变量
var_quant <- c('CPI','ChinaNewsBasedEPU','GDP','alpha','belta','belta_yj','belta_yz','consumption','creditspread','finance_1','finance_2','finance_3','finance_4','finance_5','finance_6','finance_7','finance_8','finance_9','finance_10','finance_11','finance_12','finance_13','finance_14','finance_15')

#使用最优分箱的变量
var_quant_optimal <- c('alpha' ,'belta' ,'belta_yj'  ,'finance_4' ,'finance_8' ,'finance_9','finance_13')
for (q in var_quant_optimal)
{
  assign(paste0("result_",q),smbinning(df=X_train,y='isdefault',x=q,p=0.01))

}    


#使用定义分组分箱  按分位数
var_quant_other <- setdiff(var_quant,var_quant_optimal)


for (q in var_quant_other)
{
  per<-as.vector(quantile(X_train[,q],probs=seq(0,1,0.3),na.rm=T))
  breaks<-per[2:(length(per)-1)]
  assign(paste0("result_",q),
         smbinning.custom(df=X_train,y='isdefault',x=q,cuts = breaks))

}

View(result_finance_15$ivtable)


##给训练数据定量指标进行WOE转换
woe_table_quant <- data.frame()
i <- 1
for (q in var_quant) 
{
  
  assign(paste0(q,"_woe"),rep(0,nrow(X_train)))
  woe_table_quant
  if(i==1)
  {
    woe_table_quant <- as.data.frame(get(paste0(q,"_woe")))
    i <- i+1
  }
  else
  {
    woe_table_quant <- cbind(woe_table_quant,get(paste0(q,"_woe")))
    
  }
  colnames(woe_table_quant)[i] <- paste0(q,"_woe")
  
  # assign(paste0(q,"_woe"),rep(0,nrow(X_train)))
  # woe_table_quant$get(paste0(q,"_woe")) <- rep(0,nrow(X_train)) 
  # woe_table_quant <- cbind(woe_table_quant,get(paste0(q,"_woe")))
  # 
}


##计算WOE
for (i in 1:length(var_quant)) 
{
  q <- var_quant[i]
  result <- get(paste0("result_",q))
  #result$cuts
  for (j in 1:nrow(X_train)) 
  {
    if(length(result$cuts)==1)
    {
      if(X_train[j,q]<=result$cuts[1])
      {
        woe_table_quant[j,i] <- result$ivtable['WoE'][[1]][1]
      }
      
      if(X_train[j,q]>result$cuts[1])
      {
        woe_table_quant[j,i] <- result$ivtable['WoE'][[1]][2]
        
        
      }
      

      #遇上woe值为inf，预留处理
      if(woe_table_quant[j,i]==Inf)
      {
        woe_table_quant[j,i]=10
      }
    }
    
    
    
    if(length(result$cuts)==2)
    {
      if(X_train[j,q]<=result$cuts[1])
      {
        woe_table_quant[j,i] <- result$ivtable['WoE'][[1]][1]
      }
      
      if((X_train[j,q]>result$cuts[1]) & (X_train[j,q]<=result$cuts[2]))
      {
        woe_table_quant[j,i] <- result$ivtable['WoE'][[1]][2]
        
        
      }
      
      
      if(X_train[j,q]>result$cuts[2])
      {
        woe_table_quant[j,i] <- result$ivtable['WoE'][[1]][3]
        
        
      }
      
      #遇上woe值为inf，预留处理
      if(woe_table_quant[j,i]==Inf)
      {
        woe_table_quant[j,i]=10
      }
    }
    
    if(length(result$cuts)==3)
    {
      if(X_train[j,q]<=result$cuts[1])
      {
        woe_table_quant[j,i] <- result$ivtable['WoE'][[1]][1]
      }
      
      if((X_train[j,q]>result$cuts[1]) & (X_train[j,q]<=result$cuts[2]))
      {
        woe_table_quant[j,i] <- result$ivtable['WoE'][[1]][2]
      }
      
      
      if((X_train[j,q]>result$cuts[2])&(X_train[j,q]<=result$cuts[3]))
      {
        woe_table_quant[j,i] <- result$ivtable['WoE'][[1]][3]
      }
      
      if(X_train[j,q]>result$cuts[3])
      {
        woe_table_quant[j,i] <- result$ivtable['WoE'][[1]][4]
      }
      
      #遇上woe值为inf，预留处理
      if(woe_table_quant[j,i]==Inf)
      {
        woe_table_quant[j,i]=10
      }
    }
    
    
  }
  
}



model_data <- cbind(woe_table_factor,woe_table_quant)
logr <- glm(is_default~.,data=model_data,family = binomial)
predicted_ori <- predict(logr,type = 'response')
summary(logr)


##计算得分 
A_B <- function(basepoints,baseodds,pdo)
{
  beta <- pdo/log(2)
  alpha <- basepoints+beta*log(baseodds)
  return(list(A=alpha,B=beta))
}
x <- A_B(600,1,20)
x
cof <- logr$coefficients
basepoint <- round(x$A-x$B*cof[1],1)
basepoint


model_data <- cbind(model_data,"code"=X_train[,'code'])
model_data$score <- x$A-x$B*log(predicted_ori/(1-predicted_ori))
model_data$PD <- predicted_ori
model_data2 <- model_data[order(-model_data$PD),]
View(model_data2[,c('code','is_default','PD','score')])
