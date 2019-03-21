library(survival)
library(survminer)

esprSet<-read.csv("")
group <- ifelse(esprSet$>median(esprSet$),'high','low')
sfit <- survfit(Surv(times, patient.vital_status)~group, data=esprSet)
ggsurvplot(sfit, conf.int=F, pval=TRUE)
sfit
summary(sfit)
ggsurvplot(sfit, conf.int=F, pval=TRUE)

all: survfit(formula = Surv(times, patient.vital_status) ~ group, 
    data = esprSet)

   2 observations deleted due to missingness 
            n events median 0.95LCL 0.95UCL
group=high 27      8   1492     643      NA
group=low  27      4   2821    1310      NA

Call: survfit(formula = Surv(times, patient.vital_status) ~ group, 
    data = esprSet)

2 observations deleted due to missingness 
                group=high 
 time n.risk n.event survival std.err lower 95% CI upper 95% CI
    0     26       2    0.923  0.0523       0.8261        1.000
   23     20       1    0.877  0.0670       0.7550        1.000
   31     18       1    0.828  0.0790       0.6869        0.999
   43     17       1    0.779  0.0881       0.6246        0.973
  156     13       1    0.720  0.0997       0.5484        0.944
  643      5       1    0.576  0.1514       0.3437        0.964
 1492      2       1    0.288  0.2171       0.0656        1.000

                group=low 
 time n.risk n.event survival std.err lower 95% CI upper 95% CI
  228     16       1    0.938  0.0605       0.8261            1
  715      7       1    0.804  0.1344       0.5790            1
 1310      5       1    0.643  0.1795       0.3719            1
 2821      2       1    0.321  0.2444       0.0724            1