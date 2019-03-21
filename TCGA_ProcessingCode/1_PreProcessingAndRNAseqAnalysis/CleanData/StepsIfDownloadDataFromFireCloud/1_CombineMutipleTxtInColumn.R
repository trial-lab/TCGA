#set the path of the folder which contain all .txt/.csv files need to combine 
mypath = ""
setwd(mypath)
txt_files_ls = list.files(path=mypath, pattern="*.txt")
txt_files_df <- lapply(txt_files_ls, function(x) {read.table(file = x, sep = '\t', stringsAsFactors = F)})
combined_df <- do.call("cbind", lapply(txt_files_df, as.data.frame))
write.table(combined_df, "test.txt", quote=F, sep='\t', row.names=F, col.names = F)
