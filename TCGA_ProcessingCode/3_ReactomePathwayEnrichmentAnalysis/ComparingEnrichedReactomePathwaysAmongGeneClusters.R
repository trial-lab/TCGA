require(clusterProfiler)
library(ReactomePA)
data<-read.csv("")
#data file format is the first row is the name of list gene, column is significant gene id
res <- compareCluster(data, fun="enrichPathway")
dotplot(res)
full<-as.data.frame(res)
write.csv(full,"/Users/yuanyuanshen/Desktop/")