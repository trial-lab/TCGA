library(ggplot2)
#data<- read.table("~/Desktop/READ_diffSig_expression.xls",header=T,row.names=1)
data<- read.csv("")
threshold<-as.factor((data$logFC>1.5|data$logFC< -1.5)& data$PValue<0.05)
gp<-ggplot(data,aes(x=logFC,y=-log10(PValue),colour= threshold))+xlab("log2fold change")+ylab("-log10P-Value")+geom_point()+geom_hline(yintercept=-log10(0.05),linetype=4)+geom_vline(xintercept=c(-1.5,1.5),linetype=4)
ggsave("/Users/yshpf/Desktop/READ.png")


