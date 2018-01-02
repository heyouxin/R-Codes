getData <- function(session)
{

  SQH <- session %>%   
    html_nodes("td:nth-child(2) > a:nth-child(1)") %>%
    html_text()
  SQH
  SXRQ <-session %>%   
    #html_nodes("td:nth-child(6) > span:nth-child(2)") %>%
    html_nodes("td:nth-child(5) > a:nth-child(1)")%>%
    html_text()
  SXRQ
   data <- data.frame(SQH,SXRQ)
  return data
  
}