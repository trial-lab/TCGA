#original scripts https://davetang.org/muse/2017/03/16/matrix-to-adjacency-list-in-r/
#column gene name, row sample name
data<-read.csv("")
data=t(data)
#the first column header free
write.table(data, "", col.names=F, sep=",")
data<-read.csv("")
matrix(as.numeric(unlist(data)),nrow=nrow(data))
data<-data[,-1] 
data1<-cor(data)
my_cor_matrix<-abs(data1)
my_cor_matrix[upper.tri(my_cor_matrix)] <- 42
library(reshape2)
my_cor_df <- melt(my_cor_matrix)
head(my_cor_df)
dim(my_cor_df)
library(dplyr)
my_cor_df <- filter(my_cor_df, value != 42) %>% filter(Var1 != Var2)
#dim(my_cor_df)
#head(my_cor_df)
summary(my_cor_df$value)
my_adj_list <- my_cor_df %>% filter(value > 0.9)
write.csv(my_adj_list,"")
write.table(my_adj_list,"")
#can write a csv to see how many genes have R>0.85
names(my_adj_list) <- c('from', 'to', 'weight')
class(my_adj_list)
dim(my_adj_list)
library(igraph)
net <- graph.data.frame(my_adj_list, directed = FALSE)
orig_mar <- par()$mar 
par(mar=rep(.1, 4)) 
#plot(net, layout = layout_components(net), edge.width = E(net)$weight) have something wrong with this,but plot(net)/plot(net,edge.width = E(net)$weight) is working
plot(net)
plot(net, layout = layout_components(net), edge.width = E(net)$weight, vertex.shape="none")
