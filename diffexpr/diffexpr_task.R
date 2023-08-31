#in this assignment, you will perform a differential expression analysis

#load the dataset "cervical" from the NBLDA package




#install BiocManager, limma & edgeR





#load edgeR (this will load limma as a dependency)


#create a DGEList object of "cervical" called "cerv0"


#compute normalization factors & save under "cerv0"


#set the "cutoff" to "1"


#calculate the max CPM value for each gene
#store genes with a max CPM value below the cutoff under "drop"


#create a new DGEList object called "cerv" by excluding "drop"


#look at the number of genes left in "cerv"


#extract the sample names of "cervical" into a variable called "sample_names"


#extract the first letter (N/T) of the sample names into a variable called "group"


#convert the "group" vector into a numeric vector called "group_numeric"
#convert "N" to 1, "T" to 2


#create an MDS plot with plotMDS() & specify the sample colors based on their groups
#assign the result to "MDS_plot"


#create a "design" matrix with model.matrix()


#voom() "cerv" & "design" into a variable called "cervoom"
#generate a mean-variance plot


#fit the linear model into a variable called "fit"


#create a contrast matrix ("N" vs "T") called "contrast_matrix"
#set "levels" to the names of the coefficients in "fit"


#fit the contrast model into a variable called "fit_contrast"


#apply eBayes() to "fit_contrast" & save under "fit_contrast"


#extract the top miRNA with topTable()
#sort by the p-values
#assign the result to "top.table"
