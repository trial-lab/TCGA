#how to choose certain column contain certain characters/letters
df<-read.csv("")
library("dplyr")
#keep the first column,the header row only can contain ".",instead of ","
df1<-select(df,c(1,contains("msi.h")))
head(df1)
write.csv(df1,file="")
