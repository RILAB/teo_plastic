# Use package
library(DESeq)

# Read counts
setwd("~/Desktop/")
countsTable = read.table("~/Desktop/merged_counts.txt",header=T,row.names=1)

# Describe groups
groups = c(rep("265",12), rep("400", 11))

# Make a CountDataSet
cds = newCountDataSet(countsTable, groups)
# Estimate effective library size
cds = estimateSizeFactors(cds)
# Core assumption of the method: variance is a function of expression level
# Estimate variance for each gene
cds = estimateDispersions(cds)
# Do stats based on a negative binomial distribution
results = nbinomTest(cds, "265", "400")
write.table(results, file="DESeq_output.txt", sep="\t", quote=F)

# Data quality assessment by sample clustering and visualisation (optional)
library(gplots)
library("RColorBrewer")
#re-estimate dispersion with method "blind" to ensure analysis is unbiased.
cdsFullBlind=estimateDispersions(cds, method="blind")
#vst needed for PCA and heatmap
vsd=varianceStabilizingTransformation(cdsFullBlind)

#do heatmap 
dists=dist(t(exprs(vsd)))
mat=as.matrix(dists)
rownames(mat) = colnames(mat) = with(pData(cds), paste(groups, sep=" : "))
hmcol = colorRampPalette(brewer.pal(9, "GnBu"))(100)
heatmap.2(mat, trace="none", col = rev(hmcol), margin=c(13, 13))

#do PCA
print(plotPCA(vsd, intgroup=c("condition")))
