








library(curl)
library(rvest)
library(xml2)
library(stringr)
setwd("~/Documents/GitHub/GovInfo_ExtractR")

#url <- "https://api.govinfo.gov/packages/PLAW-117publ58/zip?api_key=HvYaNtGs2VGue4nOAMX2fMMSm4CXNlkESzJg1OGt"

url <- "https://api.govinfo.gov/packages/USCODE-2022-title23/zip?api_key=HvYaNtGs2VGue4nOAMX2fMMSm4CXNlkESzJg1OGt"
curl_download(url, file.path(getwd(), 'GovInfoExtractR/R/www/tmp.zip'))
unzip(file.path(getwd(), 'GovInfoExtractR/R/www/tmp.zip'), exdir=file.path(getwd(), 'GovInfoExtractR/R/www'))

titles <-c(
  'USCODE-2022-title23-chap1-sec104',
  'USCODE-2022-title23-chap1-sec134',
  'USCODE-2022-title23-chap1-sec135'
)
for (t in titles){
  file <- file.path(getwd(), 'GovInfoExtractR/R/www/USCODE-2022-title23/html', paste0(t, '.htm'))
  df <- create_df(file)
  write.csv(df, paste0(t, '.csv'))
}

url <- "https://api.govinfo.gov/packages/USCODE-2021-title49/zip?api_key=HvYaNtGs2VGue4nOAMX2fMMSm4CXNlkESzJg1OGt"
curl_download(url, file.path(getwd(), 'GovInfoExtractR/R/www/tmp.zip'))
unzip(file.path(getwd(), 'GovInfoExtractR/R/www/tmp.zip'), exdir=file.path(getwd(), 'GovInfoExtractR/R/www'))

titles <-c(
  'USCODE-2021-title49-subtitleIII-chap53-sec5303',
  'USCODE-2021-title49-subtitleIII-chap53-sec5304',
  'USCODE-2021-title49-subtitleIII-chap53-sec5305'
)
for (t in titles){
  file <- file.path(getwd(), 'GovInfoExtractR/R/www/USCODE-2021-title49/html', paste0(t, '.htm'))
  df <- create_df(file)
  write.csv(df, paste0(t, '.csv'))
}

url <- "https://api.govinfo.gov/packages/CFR-2022-title43-vol1/xml?api_key=HvYaNtGs2VGue4nOAMX2fMMSm4CXNlkESzJg1OGt"
curl_download(url, file.path(getwd(), 'GovInfoExtractR/R/www/tmp.xml'))
unzip(file.path(getwd(), 'GovInfoExtractR/R/www/tmp.zip'), exdir=file.path(getwd(), 'GovInfoExtractR/R/www'))

url <- "https://api.govinfo.gov/packages/USCODE-2022-title42/zip?api_key=HvYaNtGs2VGue4nOAMX2fMMSm4CXNlkESzJg1OGt"
curl_download(url, file.path(getwd(), 'GovInfoExtractR/R/www/tmp.zip'))
unzip(file.path(getwd(), 'GovInfoExtractR/R/www/tmp.zip'), exdir=file.path(getwd(), 'GovInfoExtractR/R/www'))

titles <-c(
  'USCODE-2022-title42-chap1-sec104',
  'USCODE-2022-title42-chap1-sec134',
  'USCODE-2022-title42-chap1-sec135'
)
for (t in titles){
  file <- file.path(getwd(), 'GovInfoExtractR/R/www/USCODE-2022-title23/html', paste0(t, '.htm'))
  df <- create_df(file)
  write.csv(df, paste0(t, '.csv'))
}


