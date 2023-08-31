#load the survival & survminer packages
library(survival)
library(survminer)

#load the dataset
cervsurv <- read.csv("cervical_survival.csv")

#create a Surv object called "sobj"
sobj <- Surv(cervsurv$Time, cervsurv$Status)

#fit the Kaplan-Meier curves & assign the result to "km"
km <- survfit(sobj ~ 1, data = cervsurv)

#create a Kaplan-Meier plot with number at risk & assign the result to "km_plot"
km_plot <- ggsurvplot(km, risk.table = TRUE, surv.median.line = "hv")

#fit the Kaplan-Meier curves with covariates & assign the result to "km_type"
km_type <- survfit(sobj ~ Type, data = cervsurv)

#create a Kaplan-Meier plot with number at risk and p-value & assign the result to "km_type_plot"
km_type_plot <- ggsurvplot(km_type, data = cervsurv, risk.table = TRUE, surv.median.line = "hv", pval = TRUE)