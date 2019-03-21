#running on lewis
ssh yshpf@lewis.rnet.missouri.edu
module load R/R-3.3.3
R
RNAseq <- read.csv("/home/yshpf/data/test1.csv")


RNAseq <- read.csv("~/Desktop/test1.csv") 
head(RNAseq)
RNAseq =as.matrix(RNAseq)
rownames(RNAseq)= RNAseq[,1]
exp= RNAseq[,2:ncol(RNAseq)]
dimnames=list(rownames(exp),colnames(exp))
RNAseq =matrix(as.numeric(as.matrix(exp)),nrow = nrow(exp),dimnames = dimnames)
head(RNAseq)
RNAseq = RNAseq[apply(RNAseq,1,function(x) sum(x==0))<ncol(RNAseq)*0.8,]
library(limma)
RNAseq_voom = voom(RNAseq)$E
WGCNA_matrix = t(RNAseq_voom[order(apply(RNAseq_voom,1,mad), decreasing = T)[1:5000],])


library(dynamicTreeCut)
library(fastcluster)
library(WGCNA)
s = abs(bicor(WGCNA_matrix))
powers = c(c(1:10), seq(from = 12, to=20, by=2))
sft = pickSoftThreshold(WGCNA_matrix, powerVector = powers, verbose = 5)
plot(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     xlab='Soft Threshold (power)',ylab='Scale Free Topology Model Fit,signed R^2',
     type='n', main = paste('Scale independence'))
text(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     labels=powers,cex=1,col='red'); abline(h=0.90,col='red')
     
     
beta = 3
a = s^beta
w = 1-a

#Identification of co-expression modules

geneTree = hclust(as.dist(w), method = 'average')

#module identification using dynamic tree cut algorithm
modules = cutreeDynamic(dendro = geneTree, distM = w, deepSplit = 4, pamRespectsDendro = FALSE, minClusterSize = 30)
#assign module colours
module.colours = labels2colors(modules)

#plot the dendrogram and corresponding colour bars underneath
plotDendroAndColors(geneTree, module.colours, 'Module colours', dendroLabels = FALSE, hang = 0.03, addGuide = TRUE, guideHang = 0.05, main='')
library(ape)
#calculate eigengenes
MEs = moduleEigengenes(WGCNA_matrix, colors = module.colours, excludeGrey = FALSE)$eigengenes

#calculate dissimilarity of module eigengenes
MEDiss = 1-cor(MEs)

#cluster module eigengenes
METree = hclust(as.dist(MEDiss), method = 'average')

#plot the result with phytools package
par(mar=c(2,2,2,2))
plot.phylo(as.phylo(METree),type = 'fan',show.tip.label = FALSE, main='')
tiplabels(frame = 'circle',col='black', text=rep('',length(unique(modules))), bg = levels(as.factor(module.colours)))