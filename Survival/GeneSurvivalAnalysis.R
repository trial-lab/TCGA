#https://mp.weixin.qq.com/s/fuB0bLyllL_33_Shz7rKnw
#when prepare files,copy1-25genes in the end of gene list, for some reasons always have errors
#惨痛的教训！！！！检查一下数据不要有全是0的基因值！！！！！！！！！！
#1st column is id, 2ed times, 3rd patient.vital_status


library(dplyr)
library(survival)
esprSet <-read.csv("")
my.surv <- Surv(esprSet$times, esprSet$patient.vital_status)
library(parallel)
cl.cores <- detectCores()
cl <- makeCluster(6)
clusterExport(cl,c("esprSet","my.surv"))
log_rank_p <- parApply(cl,esprSet[,25:length(names(esprSet))-2],2,function(values){
    group=ifelse(values>median(na.omit(values)),'high','low')
    kmfit2 <- survival::survfit(my.surv~group,data=esprSet)
    data.survdiff=survival::survdiff(my.surv~group)
    p.val = 1 - pchisq(data.survdiff$chisq, length(data.survdiff$n) - 1)
})
stopCluster(cl)
log_rank_p <- log_rank_p[log_rank_p<0.05]
gene_diff <- as.data.frame(sort(log_rank_p))
write.csv(gene_diff,"")


