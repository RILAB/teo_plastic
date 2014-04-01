x<-read.table("~/Desktop/SummaryFinalOfCallsDelAlleles",header=T)

centromere=c(134,93,100,106,105,50,60,50,72,51)*1E6

winsize=20E6
for(chr in 1:11){
y<-subset(x,x$Chr==chr)
numwin=round(max(y$Position)/winsize)
bob=matrix(nrow=numwin,ncol=2); 
for (i in 1:numwin){ 
  min=winsize*i; 
  max=min+winsize; 
  bob[i,1]=(min+winsize/2); 
  z<-subset(y,y$Position>=min & y$Position <= max); 
 # bob[i,4]=table()
  bob[i,2]=sum(table(z$MappAll)[1])/sum(table(z$MappAll)); 
}
sue=t(bob)
barplot(sue[2,],main=paste("Chromosome",chr),ylab="Proportion nonsynomyous")
axis(side=1,labels=c(1:43)*7,at=c(1:43)*1.2)
abline(v=centromere[chr]/winsize,col="red",lwd=2)
}

a<-subset(y$Position,y$MappAll=="D")
hist(a)


