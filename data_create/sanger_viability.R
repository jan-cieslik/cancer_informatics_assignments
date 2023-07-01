#downloaded from depmap: https://depmap.org/portal/download/all/
#original data is from SANGER GDSC 
library(data.table)
x <- fread("data_create/sanger-viability.csv")
cosmic <- fread("data_create/cosmic.txt")
x_merge <- merge(x, cosmic, by="COSMIC_ID")
y <- x_merge[(Cell.Line == "MCF7" | Cell.Line =="MDA-MB-231") & (
  (DRUG_NAME == "NIRAPARIB") | (DRUG_NAME == "FULVESTRANT") | (DRUG_NAME == "TAMOXIFEN")
  | (DRUG_NAME == "DOCETAXEL"))]

write.csv(y, "sanger.csv")
