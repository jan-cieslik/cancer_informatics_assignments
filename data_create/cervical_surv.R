#downloaded from cBioPortal: https://www.cbioportal.org/study/summary?id=cervix_msk_2023
#original data is from "Cervical Cancer (MSK, 2023)"
library(readr)
library(dplyr)
cervsurv <- read_tsv("cervix_msk_2023_clinical_data.tsv")
cervsurv <- as.data.frame(cervsurv)
cervsurv <- cervsurv %>% select(`Patient ID`, `Sample Type`, `Overall Survival (Months)`, `Overall Survival Status`)
cervsurv <- cervsurv %>% mutate(`Status` = ifelse(`Overall Survival Status` == "1:DECEASED", 1, 0))
cervsurv <- cervsurv %>% mutate(`Overall Survival Status` = NULL)
cervsurv <- cervsurv %>% rename(Time = `Overall Survival (Months)`)
cervsurv <- cervsurv %>% rename(Type = `Sample Type`)
cervsurv <- cervsurv %>% rename(Patient_ID = `Patient ID`)

write.csv(cervsurv, "cervical_survival.csv")