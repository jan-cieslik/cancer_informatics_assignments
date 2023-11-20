#Inspired by ICON1 https://academic.oup.com/jnci/article/95/2/125/2912345
#Mock dataset! Created with TwoArmSurvSim

#Load the Required Packages
library(survivalAnalysis)
library(ggplot2)
library(ggsurvfit)
library(ggsci)
library(svglite)

# Load the Ovarian Cancer Dataset:
data <- read.table("http://localhost:3000/datasets/ovarian.csv", header=T, sep=",")
data <- read.table("data/ovarian.csv", header=T, sep=",")

# Explore the Dataset:
str(data)
summary(data)

#Convert to named factors
data$Treatment <- factor(data$Treatment, levels=c(0,1), labels=c("No CTX", "Adj. CTX"))
data$HighRisk <- factor(data$HighRisk, levels=c(0,1),
                           labels=c("Low Risk",
                                    "High Risk"))
#Adjust column names
colnames(data)[2] <- "RiskGroup"

#check for NA values
sum(is.na(data))
data_filtered <- na.omit(data)

#run multivariate analysis
result <- analyse_multivariate(data_filtered,
                               c("Time", "Status"),
                               covariates = c("Treatment", "RiskGroup")) 

#this is required to adjust the labels in the forest plot
#try creating the plot without this helper variable to see why we use it
covariates_labels <-   c(
  "RiskGroup:High Risk" = "High Risk",
  "Treatment:Adj. CTX" = "Adjuvant Chemotherapy"
)

#create forest plot from multivariate analysis
forest_plot(result,
            factor_labeller = covariates_labels,
            endpoint_labeller = c(futime="OS"),
            orderer = ~order(HR),
            labels_displayed = c("endpoint", "factor", "n"),
            HR_x_breaks = c(0.25, 0.5, 1, 1.5, 2, 3),
            HR_x_limits = c(0.25,3)
)

#save the plot as a svg and a pdf
ggsave("code_along/plots/ovarian_forest_plot.pdf", width=300, height=100, units = "mm", device = cairo_pdf)
ggsave("code_along/plots/ovarian_forest_plot.svg", width=300, height=100, units = "mm")

#create a kaplan meier plot
surv_obj <- survfit2(Surv(Time, Status) ~ Treatment+RiskGroup, data = data_filtered) 
ggsurvfit(surv_obj, linewidth = 1) + add_pvalue()+
  scale_color_jco() + add_censor_mark() +
  labs(
    y = "OS",
    x = "Time"
  ) + ylim(0,1)+add_risktable()

ggsave("code_along/plots/ovarian_kaplan_meier.pdf", width=200, height=150, units = "mm", device = cairo_pdf)
ggsave("code_along/plots/ovarian_kaplan_meier.svg", width=200, height=150, units = "mm")
