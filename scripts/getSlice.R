library(dplyr)
args <- commandArgs(TRUE)
data<-read.delim(args[1],sep=" ", header=FALSE) #map file
ref<-read.delim("/opt/ancestry/1000Gphase3.5superpopulations.hg19.txt,header=TRUE")
colnames(data)<-c("#chrom","ID","N","position")
slice<-left_join(select(data,'#chrom',position),ref)
write(slice,"/opt/ancestry/1000Gphase3.5superpopulations.hg19.slice.txt",quote=FALSE,sep="\t",row.names=FALSE)
