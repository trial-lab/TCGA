#query TCGA clinical data from TCGAbiolinks: https://bioconductor.org/packages/devel/bioc/vignettes/TCGAbiolinks/inst/doc/clinical.html

library(TCGAbiolinks)
library(dplyr)
library(DT)
query <- GDCquery(project = "TCGA-COAD", 
                  data.category = "Clinical", 
                  file.type = "xml")
GDCdownload(query)
clinical<- GDCprepare_clinic(query, clinical.info = "patient")
#去重 remove duplicate...there are some duplicate row in the data..
df <-data.frame(clinical)
clinical<-df[!duplicated(df), ]
write.csv(clinical,"/Users/yshpf/Desktop/clinical_patients.csv")
