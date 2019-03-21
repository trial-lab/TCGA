
data<-read.csv("")

data<-read.csv("~/Desktop/test.csv")
#column convert to row if necessary, row:sample name, column:gene name,sometime need to write the talbe and change it a little bit
data<-t(data)

head(data)

as.numeric(unlist(data))

matrix(as.numeric(unlist(data)),nrow=nrow(data))

data<-data[,-1] 

head(data)

data1<-cor(data)

head(data1)

write.csv(data1, file="")

