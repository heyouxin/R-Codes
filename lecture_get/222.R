#防止加载的内存覆盖当前的全局变量，故用局部内存环境返回参数
getValue <- function(filename)
{
  load(filename)
  return (your_variable)
}

tab <- data.frame()
for (j in c()) 
{
  temp_col <- c()
  for (seed in c())
  {
    for (lam in c())
    {
      filename <- paste0("j",j,"seed",seed,"lambda0.",lam,".RData")
      temp_col <- c(temp_col,getValue(filename))
    }
  }
  tab <- cbind(tab,temp_col)
  
}




