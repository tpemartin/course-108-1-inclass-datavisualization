library(googlesheets4)
"https://docs.google.com/spreadsheets/d/1B_4mpoBECChq1ha1ioaLWeet9S1OAJquKiao2x_UBqI/edit#gid=1493509862" %>%
  read_sheet(sheet="網頁作業上傳") ->
  .sheet

library(dplyr)
.sheet %>% 
  filter(`作業代碼（請勿自填）` =="finalProject") ->
  df_uploads

save(df_uploads,file="df_uploads.Rda")
