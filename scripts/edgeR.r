library("edgeR")
library("wesanderson")
setwd("~/Desktop/")
get files
system('rsync farm:~/projects/teo_plastic/data/*.count ./')
files<-c("265_1A.count","265_2B.count","265_3C.count","265_1A_2.count","265_2B_2.count","265_4A.count","265_1B.count","265_3A.count","265_4B.count","265_2A.count","265_3B.count","265_4C.count","400_1A.count","400_2B.count","400_3C.count","400_1A_2.count","400_2B_2.count","400_4A.count","400_1B.count","400_3A.count","400_4C.count","400_2A.count","400_3B.count")


counts=readDGE(files)$counts
metadat<-data.frame(files)
metadat$shortname=colnames(counts)
metadat$co2=c(rep(265,12),rep(400,11))
noint=rownames(counts) %in% c("no feature","ambiguous","too_low_aQual","not_aligned","alignment_not_unique")
cpms<-cpm(counts)
keep=rowSums(cpms>1) >= 3 & !noint
new.counts<-counts[keep,]
head(new.counts[,order(metadat$co2)],5)
d=DGEList(counts=new.counts,group=metadat$co2)
d2=calcNormFactors(d)
plotMDS(d2,pch=16,labels=metadat$shortname,cex=.75,col=c("darkgreen","blue")[factor(metadat$co2)])
d3=estimateCommonDisp(d2)
d4=estimateTagwiseDisp(d3)
plotMeanVar(d4,show.tagwise.vars=TRUE,NBline=TRUE)
plotBCV(d4)
de=exactTest(d4)
tt=topTags(de,n=nrow(d4))            
head(tt$table)
nc=cpm(d4,normalized.lib.sizes=TRUE)
rn=rownames(tt$table)
head(nc[rn,order(metadat$co2)],5)
deg=rn[tt$table$FDR<0.01]
plotSmear(d4,de.tags=deg)
write.csv(tt$table,file="toptags_edgeR.csv")

tops<-scan(what="character")
for(i in tops){ print(paste(i,min(tt$table[grep(i,rownames(tt$table)),]$FDR)))} 
dif <- as.logical(abs(decideTestsDGE(de)))

