source("https://bioconductor.org/biocLite.R")
biocLite("edgeR")
library(limma)
library(edgeR)
setwd("")
mydata <- read.csv("")
head(mydata)
mydata=as.matrix(mydata)
rownames(mydata)=mydata[,1]
exp=mydata[,2:ncol(mydata)]
dimnames=list(rownames(exp),colnames(exp))
mydata=matrix(as.numeric(as.matrix(exp)),nrow = nrow(exp),dimnames = dimnames)
mydata=avereps(mydata)
mydata=mydata[rowMeans(mydata)>1,]
ncol(mydata)
 #need to check each time, control group with test group
group=c(rep("control",55),rep("study",63))
design<- model.matrix(~group)
y <-DGEList(counts=mydata, group=group)
y <- calcNormFactors(y)
y <- estimateCommonDisp(y)
y <- estimateTagwiseDisp(y)
et <- exactTest(y,pair = c("control","study"))
topTags(et)
ordered_tags <- topTags(et, n=100000)
fc=1
p=0.05
allDiff=ordered_tags$table
allDiff=allDiff[is.na(allDiff$FDR)==FALSE,]
diff=allDiff
head(diff)
newData=y$pseudo.counts

diffSig = diff[(diff$FDR < p & (diff$logFC>fc | diff$logFC<(-fc))),]
write.table(diff,file="edgerOut.csv",sep="\t",quote=F)

diffUp = diff[(diff$FDR < p & (diff$logFC>fc)),]
write.table(diffUp, file="up.csv",sep="\t",quote=F)

diffDown = diff[(diff$FDR < p & (diff$logFC<(-fc))),]
write.table(diffDown, file="down.csv",sep="\t",quote=F)

normalizeExp=rbind(id=colnames(newData),newData)
write.table(normalizeExp,file="normalizeExp.csv",sep="\t",quote=F,col.names=F)

diffSig = diff[(diff$FDR < p & (diff$logFC>fc | diff$logFC<(-fc))),]
write.csv(diffSig,"~/Desktop/diffSig.csv")

write.table(diffSig, file="diffSig.xls",sep="\t",quote=F)
