library(ggplot2)
library(dplyr)
library(survival)
library(survminer)

esprSet <-read.csv("")

group <- ifelse(esprSet$ARG1>median(esprSet$ARG1),'high','low')
sfit <- survfit(Surv(times, patient.vital_status)~group, data=esprSet)
sfit
summary(sfit)
gp<-ggsurvplot(sfit, conf.int=F, pval=TRUE)
ggsave("/Users/yshpf/Desktop/Supplementary2/REC_MSS_LOC/ARG1.png")
