library(pathview)
library(ReactomePA)
library(clusterProfiler)

d = read.csv("")
geneList = d[,2]
names(geneList) = as.character(d[,1])
geneList = sort(geneList, decreasing = TRUE)


# An R package for Reactome Pathway Analysis
#  http://www.bioconductor.org/packages/devel/bioc/vignettes/ReactomePA/inst/doc/ReactomePA.html
#Pathway Enrichment Analysis
de <- names(geneList)[abs(geneList) > 1.5]
head(de)
x <- enrichPathway(gene=de,pvalueCutoff=0.05, readable=T)
dim(as.data.frame(x))
head(as.data.frame(x))
#save x
options(max.print=1000000)
sink("")
print(as.data.frame(x))
sink()


#Pathway analysis of NGS data
#Visualize enrichment result
barplot(x, showCategory=8)
dotplot(x, showCategory=15)
emapplot(x)
cnetplot(x, categorySize="pvalue", foldChange=geneList)



#Comparing enriched reactome pathways among gene clusters with clusterProfiler
require(clusterProfiler)
data(gcSample)
gcSample<-read.csv("")
res <- compareCluster(gcSample, fun="enrichPathway")
dotplot(res)

#Gene Set Enrichment Analysis
y <- gsePathway(geneList, nPerm=10000,
                pvalueCutoff=0.2,
                pAdjustMethod="BH", verbose=FALSE)
res <- as.data.frame(y)
dim(res)
head(res)

options(max.print=1000000)
sink("")
print(res)
sink()
#Visualize GSEA result
emapplot(y, color="pvalue")
gseaplot(y, geneSetID = "R-HSA-69242")
#Pathway Visualization
viewPathway("E2F mediated regulation of DNA replication", readable=TRUE, foldChange=geneList)


#pathview from pathview package
kk <- enrichKEGG(gene = gene,organism = 'hsa',pvalueCutoff = 0.05)
as.data.frame(kk)
library("pathview")
hsa05202<- pathview(gene.data  = geneList,
                     pathway.id = "hsa05202",
                     species    = "hsa",
                     limit      = list(gene=max(abs(geneList)), cpd=1))

#Visualization
#browseKEGG
browseKEGG(kk, 'hsa04110')
#browseKEGG(kk, 'hsa04110')
library("pathview")
hsa03320 <- pathview(gene.data  = geneList,
                     pathway.id = "hsa03320",
                     species    = "hsa",
                     limit      = list(gene=max(abs(geneList)), cpd=1))


#GO classification
d = read.csv("")
library(DOSE)
geneList = d[,2]
names(geneList) = as.character(d[,1])
geneList = sort(geneList, decreasing = TRUE)
gene <- names(geneList)[abs(geneList) > 1.5]
gene.df <- bitr(gene, fromType = "ENTREZID",
                toType = c("ENSEMBL", "SYMBOL"),
                OrgDb = org.Hs.eg.db)
head(gene.df)

mkk2 <- gseGO(geneList = geneList,
                 species = 'hsa')


