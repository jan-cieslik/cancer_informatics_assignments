#in this assignment, you will perform a differential expression analysis

#load the dataset "cervical" from the NBLDA package
install.packages("NBLDA")
library(NBLDA)
data(cervical)

#install BiocManager, limma & edgeR
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("limma")
BiocManager::install("edgeR")

#load edgeR (this will load limma as a dependency)
library(edgeR)

#create a DGEList object of "cervical" called "cerv0"
cerv0 <- DGEList(cervical)

#compute normalization factors & save under "cerv0"
cerv0 <- calcNormFactors(cerv0)

#set the "cutoff" to "1"
cutoff <- 1

#calculate the max CPM value for each gene
#store genes with a max CPM value below the cutoff under "drop"
drop <- which(apply(cpm(cerv0), 1, max) < cutoff)

#create a new DGEList object called "cerv" by excluding "drop"
cerv <- cerv0[-drop,]

#look at the number of genes left in "cerv"
dim(cerv)

#extract the sample names of "cervical" into a variable called "sample_names"
sample_names <- colnames(cervical)

#extract the first letter (N/T) of the sample names into a variable called "group"
group <- substr(sample_names, 1, 1)

#convert the "group" vector into a numeric vector called "group_numeric"
#convert "N" to 1, "T" to 2
group_numeric <- ifelse(group == "N", 1, 2)

#create an MDS plot with plotMDS() & specify the sample colors based on their groups
#assign the result to "MDS_plot"
MDS_plot <- plotMDS(cerv, col = group_numeric)

#create a "design" matrix with model.matrix()
design <- model.matrix(~ 0 + group)

#voom() "cerv" & "design" into a variable called "cervoom"
#generate a mean-variance plot
cervoom <- voom(cerv, design, plot = TRUE)

#fit the linear model into a variable called "fit"
fit <- lmFit(cervoom, design)

#create a contrast matrix ("N" vs "T") called "contrast_matrix"
#set "levels" to the names of the coefficients in "fit"
contrast_matrix <- makeContrasts(groupN - groupT, levels = colnames(coef(fit)))

#fit the contrast model into a variable called "fit_contrast"
fit_contrast <- contrasts.fit(fit, contrast_matrix)

#apply eBayes() to "fit_contrast" & save under "fit_contrast"
fit_contrast <- eBayes(fit_contrast)

#extract the top miRNA with topTable()
#sort by the p-values
#assign the result to "top.table"
top.table <- topTable(fit_contrast, sort.by = "P")