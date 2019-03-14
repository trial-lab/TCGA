library(devtools)
library(MCPcounter)
df<-read.csv("",header=TRUE,row.names=1)
#replace the first gene_id column to HUGO_symbols
mcpcounter_estimates <- MCPcounter.estimate(df,"HUGO_symbols")
heatmap(as.matrix(mcpcounter_estimates),col=colorRampPalette(c("blue","white","red"))(100))
write.csv(mcpcounter_estimates,"")