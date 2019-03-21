#original scripts https://davetang.org/muse/2017/03/16/matrix-to-adjacency-list-in-r/
#column gene name, row sample name
data<-read.csv("")
data=t(data)
#the first column header free
write.table(data, "", col.names=F, sep=",")
data<-read.csv("")