#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("GEOquery")
#BiocManager::install("limma")
#BiocManager::install("preprocessCore")
#install.packages("ggplot2")

#Load Packages
library(GEOquery)
library(limma)
library(preprocessCore)
library(ggplot2)
library(class)
library(ggfortify)
library(Rtsne)

# Download the dataset
gset <- getGEO("GSE2034", GSEMatrix = TRUE, AnnotGPL = TRUE)
gpl <- getGEO("GPL96")

# Extract the expression data
exprs <- exprs(gset[[1]])

# Extract the phenotype data
pData <- pData(gset[[1]])

# We define a index (idx) to align the order from the GPL and GSE probe names 
idx <- which(Table(gpl)$ID %in% rownames(exprs))
# Get gene names from gpl and append it to the expression table
geneMatrix <- cbind(exprs, Table(gpl)[idx, "Gene Symbol", drop=FALSE])
# Some genes have multiple probes,
# so we need to make the probe names unique to utilize them as rownames
rownames(geneMatrix) <- make.unique(geneMatrix[, "Gene Symbol"])
# Remove the last column, which is the gene symbol column
# (as we already have the gene names as rownames)
geneMatrix <- geneMatrix[,1:length(geneMatrix)-1]
# Convert the data.frame to a numeric matrix
geneMatrix <- as.matrix(geneMatrix)


geneMatrix.norm <- normalize.quantiles(geneMatrix, keep.names=T)
svg("code_along/plots/breast_boxplot.svg")
par(mar = c(0, 0, 0, 0))
boxplot(geneMatrix[,1:40], outline = F, las = 2, xaxt="n")
dev.off()

#svg() is used to redirect the plot to a file
#dev.off() is required to indicated where to close the output stream to the svg file
svg("code_along/plots/breast_boxplot_norm.svg")
par(mar = c(0, 0, 0, 0))
boxplot(geneMatrix.norm[,1:40], outline = F, las = 2, xaxt="n")
dev.off()

# use t() to transform i.e. flip a matrix (turn columns into rows and vice-versa)
geneMatrix.norm.t <- t(geneMatrix.norm)

# extract clinical data, the rownames(...) part is required to keep the clinical data in the same order as the expression data
bone_relapse <- pData[rownames(geneMatrix.norm.t),"bone relapses (1=yes, 0=no):ch1"]

# create a dataframe with clinical data and gene expression data
df <- cbind(geneMatrix.norm.t, bone_relapse)

# perform PCA
pca_res <- prcomp(geneMatrix.norm.t, scale. = TRUE, center=T)
autoplot(pca_res, colour ="bone_relapse", data=df) +theme_classic()+ theme(legend.position="bottom")
ggsave("code_along/plots/breast_pca.pdf", width=100, height=100, units = "mm", device = cairo_pdf)
ggsave("code_along/plots/breast_pca.svg", width=100, height=100, units = "mm")


# Perform tSNE and plot via ggplot. Code adapted from:
# https://stackoverflow.com/questions/44837536/how-to-use-ggplot-to-plot-t-sne-clustering
tsne <- Rtsne(geneMatrix.norm.t)
plot(tsne$Y, col=bone_relapse)
tsne_plot <- data.frame(x = tsne$Y[,1], y = tsne$Y[,2],
                        col = bone_relapse)
ggplot(tsne_plot) + geom_point(aes(x=x, y=y, color=col)) +theme_classic()+ theme(legend.position="bottom")
ggsave("code_along/plots/breast_tsne.pdf", width=100, height=100, units = "mm", device = cairo_pdf)
ggsave("code_along/plots/breast_tsne.svg", width=100, height=100, units = "mm")