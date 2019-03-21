#find our overlap genes
library(VennDiagram)
test<-read.csv("/Users/yshpf/Desktop/test.csv")
test_R<-test$R_diffsig
test_T<-test$T_diffsig
test_L<-test$L_diffsig
test_Read<-test$Read_diffsig
venn.diagram(
  x = list(test_R , test_T , test_L, test_Read),
  category.names = c("Right" , "Transverse " , "Left","Rectum"),
  filename = 'coadreadOverlap_venn_diagramm.png',
  output = TRUE ,
  imagetype="png" ,lty = 'blank',
  fill = c('#fbb4ae','#b3cde3', '#ccebc5','#decbe4')
)

#find the overlap details
x = list(test_R , test_T , test_L, test_Read)
get.venn.partitions(x)

#如果想查看所有列之间的共同值
test<-read.csv("/Users/yshpf/Desktop/test.csv")
v1<-test$T_diffsig
v2<-test$L_diffsig
v3<-test$Read_diffsig
Reduce(intersect,  list(v1,v2,v3))


