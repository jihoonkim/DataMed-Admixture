library(dplyr)
library(reshape2)
library(entropy)


args <- commandArgs(TRUE)
data<-read.delim(args[1],sep=" ", header=TRUE,stringsAsFactors=FALSE)
datamelt<-melt(data,id.vars=c("reference","sample"),variable.name="refpop",value.name="fraction")

tmp<-aggregate(data=datamelt,fraction~refpop,FUN=sum)
tmp$cumfrac<-tmp$fraction/sum(tmp$fraction)

N<-length(unique(tmp$refpop))
divscore<-(entropy::entropy.empirical(unlist(tmp$cumfrac)))/(entropy::entropy.empirical(rep(1/N,N)))

results<-data.frame(key=c(as.character(tmp$refpop),"divscore"),value=round(c(tmp$cumfrac,divscore),3))

write.table(results,stdout(),quote=FALSE,sep="\t",row.names=FALSE)