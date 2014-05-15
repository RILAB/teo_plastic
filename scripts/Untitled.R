library("edgeR")
files<-c("265_1A.count","265_2B.count","265_3C.count","265_1A_2.count","265_2B_2.count","265_4A.count","265_1B.count","265_3A.count","265_4B.count","265_2A.count","265_3B.count","265_4C.count","400_1A.count","400_2B.count","400_3C.count","400_1A_2.count","400_2B_2.count","400_4A.count","400_1B.count","400_3A.count","400_4C.count","400_2A.count","400_3B.count")
setwd("~/projects/dolores/teo_plastic/results/")
counts=readDGE(files)$counts
metadat<-data.frame(files)
metadat$shortname=colnames(counts)
metadat$co2=c(rep(265,12),rep(400,11))
noint=rownames(counts) %in% c("__no_feature","__ambiguous","__too_low_aQual","__not_aligned","__alignment_not_unique")
cpms<-cpm(counts)
keep=rowSums(cpms>1) >= 3 & !noint
og.counts<-counts[keep,]


n=1:23
ustats=as.numeric();
meanstats=as.numeric()
for(i in 1:1000){
  
  test<-c(sample(1:12,4),sample(13:23,4))
  non<-n[!(1:23 %in% test)]
  
  mz<-og.counts[,test]
  teo<-og.counts[,non]
  
  d=DGEList(counts=mz,group=metadat$co2[test])
  d2=calcNormFactors(d)
  d3=estimateCommonDisp(d2)
  d4=estimateTagwiseDisp(d3)
  de=exactTest(d4)
  mtt=topTags(de,n=nrow(d4))   
  
  e=DGEList(counts=teo,group=metadat$co2[non])
  e2=calcNormFactors(e)
  e3=estimateCommonDisp(e2)
  e4=estimateTagwiseDisp(e3)
  ee=exactTest(e4)
  ttt=topTags(ee,n=nrow(e4))   
  meanstats[i]=mean(abs(ttt$table$logFC)-abs(mtt$table$logFC))
  ustats[i]=wilcox.test(ttt$table$logFC,mtt$table$logFC)$statistic
}

