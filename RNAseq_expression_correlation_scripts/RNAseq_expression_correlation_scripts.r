
data<-read.csv("sample.csv")

data<-read.csv("~/Desktop/test.csv")
data<-read.csv("/home/yshpf/JonLab/MCPcounter/mcpcounter.test.data.mss.ForCorT.csv")




head(data)

as.numeric(unlist(data))

matrix(as.numeric(unlist(data)),nrow=nrow(data))

data<-data[,-1] 

head(data)

data1<-cor(data)

data1

write.csv(data1, file="sample1.csv")

