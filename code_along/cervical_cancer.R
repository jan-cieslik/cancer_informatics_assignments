# Load the necessary packages
library(NBLDA)
library(edgeR)
library(limma)
data(cervical)



cerv0 <- DGEList(cervical)
# Look at the first 4 rows
head(cervical, c(5,5))
cervical[1:5, c(1:3, 30:32)]

# Create a DGEList object
cerv0 <- DGEList(cervical)
cerv0$samples$group <- substr(colnames(cervical), 1, 1)

cerv0 <- calcNormFactors(cerv0)

# see https://ucdavis-bioinformatics-training.github.io/2019_March_UCSF_mRNAseq_Workshop/differential_expression/orig_DE_Analysis.html
# Set the cutoff to "1"
cutoff <- 3

# Calculate the max CPM value for each gene
# Store genes with a max CPM value below the cutoff under "drop"
drop <- which(apply(cpm(cerv0), 1, max) < cutoff)

# Create a new DGEList object by excluding "drop"
cerv <- cerv0[-drop,] 

# Look at the originial number of miRNAs
dim(cerv0)
# Look at the number of miRNAs left
dim(cerv)

group_numeric <- ifelse(cerv$samples$group == "N", 1, 2) 

# Create the MDS plot
# Specify the sample colors based on their groups
plotMDS(cerv, col = group_numeric)

counts <- t(as.matrix(cerv$counts))
df <- as.data.frame(cbind(cerv$samples$group, counts))
colnames(df)[1] <- "group"

pca_res <- prcomp(counts, scale. = TRUE, center=T)
autoplot(pca_res, colour ="group", data=df) +theme_classic()+ theme(legend.position="bottom")

# Perform tSNE and plot via ggplot. Code adapted from:
# https://stackoverflow.com/questions/44837536/how-to-use-ggplot-to-plot-t-sne-clustering
tsne <- Rtsne(counts, perplexity=floor((nrow(counts) - 1) / 3),)
#plot(tsne$Y, col=group_numeric)
tsne_plot <- data.frame(x = tsne$Y[,1], y = tsne$Y[,2],
                        col = cerv$samples$group)
ggplot(tsne_plot) + geom_point(aes(x=x, y=y, color=col)) +theme_classic()+ theme(legend.position="bottom")

