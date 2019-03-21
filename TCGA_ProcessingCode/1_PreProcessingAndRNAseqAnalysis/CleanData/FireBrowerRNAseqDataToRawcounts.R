#This is a pre-pocessing,downloaded RNAseq data from firebrower, we want to keep data just have rawcounts.If have anyquestion to read this codes, please review the video(TCGA_cleandata_by_R_3_Matt)
setwd("~/Desktop")
data <- read.table("COADREAD.rnaseqv2__illuminahiseq_rnaseqv2__unc_edu__Level_3__RSEM_genes__data.data_copy.txt", sep = '\t', stringsAsFactors = F)

# Take only the cols that are 'raw_count's
reduced.data <- data[, c(1, seq(2,ncol(data),3)) ]

write.table(reduced.data, "TCGA_COAD_REC_Rawcounts.txt", quote=F, sep='\t', row.names=F, col.names = F)

# The list of sample names
sample.names <- as.character(reduced.data[1,])[2:ncol(reduced.data)]
head(sample.names)

# Find the good columns (the ones that aren't '11A')
good.cols <- sapply(strsplit(sample.names, '-'), "[[", 4) != '11A'

sample.names
sample.names[good.cols]

# The first column (gene names) is definitely good.
good.cols <- c(TRUE, good.cols) 
sum(good.cols)

# Take the data from only these cols
tumor.tissues <- reduced.data[ , good.cols]
tumor.tissues[1,]

write.table(tumor.tissues, "TCGA_COAD_REC_Rawcounts_tumor.tissues.txt", quote=F, sep='\t', row.names=F, col.names = F)
