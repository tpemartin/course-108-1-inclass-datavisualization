library(dplyr); library(stringr); library(htmltools); library(htmlwidgets); library(plotly)

to_frameableHTML <- function(filename, regularHTML=F){
  ## regularHTML=T will treat plotly widget html as regular html
  filename %>%
    readLines() ->
    htmlContent
  if(all(!str_detect(htmlContent,"pym.Child"))){  # 沒有裝過pym 才要改裝
    
    # find Plotly.newPlot(...)
    ilocL <- str_which(htmlContent,'(Plotly\\.newPlot\\()')
    if(length(ilocL)!=0 & regularHTML==F){ # 改變html文件為Plotly widget
      ilocR <- str_which(htmlContent[ilocL:length(htmlContent)],'\\)')[[1]]+ilocL-1
      targetLine <- htmlContent[ilocL:ilocR]
      targetLineSerialized <- paste0(targetLine,collapse = '\n ')
      paste0('function drawGraphic(width) {\n',
             targetLineSerialized,'\n',
             '}\n',
             'var pymChild = new pym.Child({ renderCallback: drawGraphic });') -> newTargetLine
      
      if(ilocR>ilocL){
        htmlContent <- htmlContent[-((ilocL+1):ilocR)]
      }
      
      htmlContent[ilocL] <- newTargetLine
      ## find target id
      targetLineSerialized %>%
        str_replace_all(" ","") %>%
        str_extract("(?<=(Plot\\())[:graph:]+(?=,)")
    } else { # 改變html文件為一般html文件
      iloc_headEnd <- str_which(htmlContent,"</head>")
      paste0(
        htmlContent[[iloc_headEnd-1]],
        '\n',
        '<script type="text/javascript" src="https://pym.nprapps.org/pym.v1.min.js"></script>'
      ) -> htmlContent[[iloc_headEnd-1]]
      
      iloc_bodyEnd <- str_which(htmlContent,"</body>")
      paste0(
        htmlContent[[iloc_bodyEnd-1]],
        '\n',
        '<script> new pym.Child(); </script>'
      ) -> htmlContent[[iloc_bodyEnd-1]]
    }
    
    htmlContent %>% writeLines(filename)
    
  }  
  '<div id="example" width="100%" height="100%"></div>
<script type="text/javascript" src="https://pym.nprapps.org/pym.v1.min.js"></script>
<script>
    var pymParent = new pym.Parent("example", "filename", {});
</script>
' %>%
    str_replace("filename",filename) %>%
    cat('請在要引入圖形處貼上：\n\n',
        .,'\n',
        '請檢查scripts最後一行的路徑。\n',
        '"example"可改成自己要的id')
  
}

save_frameableWidget <- function(pltplot, filename,
         selfcontained=F, partialbundle=T){
  libdir=ifelse(selfcontained==F,dirname(filename),NULL)
  pltplot %>% 
    widgetframe::frameableWidget() -> frameable_plot
  if(partialbundle==T) {
    plotly::partial_bundle(frameable_plot) -> frameable_plot
  }
  frameable_plot %>%
    htmlwidgets::saveWidget(file=basename(filename), 
                            selfcontained = selfcontained,
                            libdir=libdir)
  file.link(from=basename(filename), to=filename)
  text <- '
  <iframe src="filename" 
  scrolling = "no" 
  seamless = "seamless" frameBorder = "0" 
  width= "100%" height="100%"></iframe>' %>%
    stringr::str_replace("filename",filename) %>%
    cat('請在html檔貼上：\n',
        'width與height依需要刪去其中一個\n',.,
        '\n\n記得檢查一下路徑')
}
