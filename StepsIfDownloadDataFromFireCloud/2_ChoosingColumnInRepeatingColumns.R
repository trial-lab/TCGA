#Choosing columns in repeating columns
#在重复列中选取所需要列
setwd("~/Desktop/MUII/OncologyBiomedicalInformatics/TCGA/TCGA_DATA/ProcessedData/DataProcessingFroClinicalCongress/Round3_OctACS/ControlledAccessData/COAD")
data <- read.table("~/Desktop/MUII/OncologyBiomedicalInformatics/TCGA/TCGA_DATA/ProcessedData/DataProcessingFroClinicalCongress/Round3_OctACS/ControlledAccessData/COAD/Coad_ControlledRNAseq/Coad_ControlledRNAseq.txt", sep = '\t', stringsAsFactors = F)
reduced.data <- data[, c(1, seq(2,ncol(data),4)) ]
write.table(reduced.data, "test1.txt", quote=F, sep='\t', row.names=F, col.names = F)