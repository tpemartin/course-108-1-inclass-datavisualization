## ----basic setup, message=FALSE, echo=TRUE, eval=T-----------------------
library(dplyr); library(stringr); library(ggplot2); library(plotly); library(lubridate); library(readr); library(tidyr); library(showtext)

font_add("QYuan","cwTeXQYuan-Medium.ttf") # 新增字體
showtext_auto(enable=TRUE) #啟用字體
theme_set(theme_classic())
 
load("graphData_homework2019-10-08_001.Rda")
## ----graph, echo=T, eval=T-----------------------------------------------
    ggplot(graphData$graphy) +
    geom_line(
      aes(x=女生,y=男生,color=等級別))+
    geom_point(
      aes(x=女生,y=男生,color=等級別)    
    )->finalplot
    finalplot

 
