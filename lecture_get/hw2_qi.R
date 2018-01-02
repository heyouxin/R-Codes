install.packages("quadprog")
library(quadprog)

ExpReturn=c(0.405533,0.49012,0.507552,0.620121,0.438577)

ExpCovariance=matrix(
  c(0.000603,0.000565,0.000644,0.000589,0.000512,
    0.000565,0.000596,0.000656,0.000612,0.000537,
    0.000644,0.000656,0.000839,0.00071,0.000648,
    0.000589,0.000612,0.00071,0.000716,0.000643,
    0.000512,0.000537,0.000648,0.000643,0.000712),nrow = 5)


frontcon <- function(ExpReturn, ExpCovariance, Numports = 10, float = 4){
  size = length(ExpReturn);
  if(dim(ExpCovariance)[1] != size | dim(ExpCovariance)[2] != size    )
    stop("Fucking size!");
  
  minReturn = round(range(ExpReturn)[1], float) + 1/10^4
  maxReturn = round(range(ExpReturn)[2], float);  ## 获得期望回报率的区间
  
  
  seqReturn = seq(minReturn, maxReturn, length.out = Numports);
  
  risks = 0; risks = risks[-1];
  for(i in 1:Numports){
    ###  二次规划求一个(return,risk)的点
    A <- cbind(rep(1, size), ExpReturn,diag(rep(1, size))) #约束系数
    D <- ExpCovariance # 协方差矩阵
    x <- ExpReturn # 期望收益
    b <- c(1, seqReturn[i], rep(0, size)) #约束的右侧值
    res <- solve.QP(2*D, x, A, b, meq = 2 )  ##   meq 指的是限制条件中，前meq个条件为"="
    
    risks = c(risks,t(res$solution) %*% ExpCovariance %*% res$solution);
  }
  
  output = data.frame(PortRisk = risks, PortReturn = round(seqReturn,float));
  return output
}


output <- frontcon(ExpReturn,ExpCovariance, 30)

library(ggplot2)
qplot(output[,1],output[,2])
