#load data from data/sanger.csv into a variable called "data"
data <- read.csv("data/sanger.csv")

#create a subset called MCF7 and MDA
#containing only data from MCF7 or MDA-MB-231
MCF7 <- data[which(data$Cell.Line == "MCF7"),]
MDA <- data[which(data$Cell.Line == "MDA-MB-231"),]

#subset the data further to only contain TAMOXIFEN data with a dose of 5
#call the new variables MCF7_Tamoxifen and MDA_Tamoxifen
MCF7_Tamoxifen <- MCF7[which(MCF7$DRUG_NAME == "TAMOXIFEN" & MCF7$dose == 5),]
MDA_Tamoxifen <- MDA[which(MDA$DRUG_NAME == "TAMOXIFEN" & MDA$dose == 5),]

#calculate the mean "viability" difference between the two groups previously defined
#assign the result to viability_diff
viability_diff <- mean(MCF7$viability) - mean(MDA_Tamoxifen$viability)

#perform a t test using t.test() between the two groups previously defined
#save the response to viability_ttest
viability_ttest <- t.test(MCF7_Tamoxifen$viability, MDA_Tamoxifen$viability)
