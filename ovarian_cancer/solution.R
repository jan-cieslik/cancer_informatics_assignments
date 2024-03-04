# Task 1: Load the simulated ovarian cancer dataset
simulated_data <- read.csv("data/ovarian_4_factors.csv")

# Task 2: Display the first five rows of the dataset
test_head <- head(simulated_data, 5)

# Task 3: Check if the dataset has the expected columns
column_names <- colnames(simulated_data)
print(column_names)

# or using names()
column_names <- names(simulated_data)
print(column_names)

# Task 4: Load library survival and survminer
library(survival) 
library(survminer)

# Task 5: Create a Kaplan-Meier survival curve using the surv_fit function and save the data as km_fit
km_fit <- surv_fit(Surv(Time, Status) ~ Treatment, data = simulated_data)

# Task 6: Extract the number of participants from the Kaplan-Meier curve and save the data as km_fit_participants
km_fit_participants <- km_fit$n

# Task 7: Extract also conf.int, n.risk, n.event and n.censor. Save the data as km_fit_confint, km_fit_nrisk, km_fit_nevent and km_fit_ncensor
# conf.int: Attribute contains the confidence intervals for the survival probabilities at each time point. These intervals provide a range within which the true survival probability is likely to lie with a certain level of confidence (e.g., 95%).
# n.risk: This represents the number of individuals at risk at each time point. At the beginning of the study, this is equal to the total number of individuals in the study. As the study progresses and individuals experience the event of interest or are censored, this number decreases.
# n.event: This represents the number of individuals who experienced the event of interest (e.g., death) at each time point. This is also called the number of failures.
# n.censor: This represents the number of individuals who were censored at each time point. Censoring occurs when an individual is lost to follow-up or withdraws from the study before experiencing the event of interest.
km_fit_confint <- km_fit[["conf.int"]]
km_fit_nrisk <- km_fit[["n.risk"]]
km_fit_nevent <- km_fit[["n.event"]]
km_fit_ncensor <- km_fit[["n.censor"]]

# Task 8: Extract the p-value using the survdiff function, which performs a log-rank test for comparing survival curves between treatment groups and save the data as km_diff.
km_diff <- survdiff(Surv(Time, Status) ~ Treatment, data = simulated_data)
km_diff_p <- km_diff$pvalue

# Task 9: Extract also chisq, obs and exp. Save the data as km_diff_chisq, km_diff_obs and km_diff_exp
# chisq: The test statistic, which is a measure of the difference in survival distributions between the groups. A larger test statistic indicates a greater difference in survival between the groups. 
# observed: The observed number of events (e.g., deaths) in each group.
# expected: The expected number of events in each group under the null hypothesis.
km_diff_chisq <- km_diff[["chisq"]]
km_diff_obs <- km_diff[["obs"]]
km_diff_exp <- km_diff[["exp"]]

# Task 10: Set the plotting parameters for the Kaplan-Meier plot. Define the x-axis label as "Time (Months)" and the y-axis label as "Survival Probability". 
# Set the main title of the plot as "Kaplan-Meier Survival Curve". 
# Limit the x-axis to the range [0, 36] months and the y-axis to the range [0, 1].
# Set the colour for the treatment group to "blue" and for the no treatment group to "red"
# Add the p-value in the plot
# Create a data containing the plot and name it ggsurvplot_graph
ggsurvplot_graph <- ggsurvplot(km_fit, 
           xlab = "Time (Months)", ylab = "Survival Probability",
           title = "Kaplan-Meier Survival Curve",
           xlim = c(0, 36), ylim = c(0, 1),
           pval = TRUE, pval.method = TRUE,
           break.time.by = 12,
           legend.labs = c("No Treatment", "Treatment"),
           legend.title = "Treatment Group",
           palette = c("red", "blue"))

# Task 2.0 Cox Regression + Boxplot + HR's
# Next we want to access the hazard ratios for the different factors and their impact one the potential outcome (event death yes or no)
# Therefore we will use the coxph function from the survival package
# The Cox proportional hazards model is a semi-parametric model that allows for the estimation of the hazard ratio (the risk of an event occurring at a given time)
# Task 11: Load library survival 
library(survival) 

# Task 12: Fit a Cox proportional hazards model using the coxph function. 
# Use status as the possible event and Treatment, RiskGroup, p53Status and BRCAStatus as possible predictors.
# Name it ovariancancer_cox_model.
ovariancancer_cox_model <- coxph(Surv(Time, Status) ~ Treatment + RiskGroup + p53Status + BRCAStatus, data = simulated_data)

# Task 13: Extract the coefficients for each predictor.
# The coefficients of the model represent the estimated log hazard ratios (log HR) for each predictor variable. 
ovariancancer_cox_model[["coefficients"]][["Treatment"]]
ovariancancer_cox_model[["coefficients"]][["RiskGroup"]]
ovariancancer_cox_model[["coefficients"]][["p53Status"]]
ovariancancer_cox_model[["coefficients"]][["BRCAStatus"]]

# Task 14:  The hazard ratios represent the ratio of the hazard rates between two groups or levels of a categorical variable. 
# They can be calculated by exponentiating the coefficients of the model.
# Therefore we will use the coef function extracting the coefficients and then exponentiating them using the exp(coef( function.
# Name the outcoming data ovariancancer_HR and print the results.
ovariancancer_HR <- exp(coef(ovariancancer_cox_model))
print(ovariancancer_HR)

# Task 15: Next we also want to extract the confidence intervals from the ovariancancer_cox_model object using the exp(confint( function.
# Name the outcoming data ovariancancer_CI and print the results. 
ovariancancer_CI <- exp(confint(ovariancancer_cox_model))
print(ovariancancer_CI)

# Task 16: Now we want to create a dataframe containing predictors [Predictor], hazard ratio [HazardRatio] and confidence intervals [CI].
# We name it ovariancancer_dataframe
ovariancancer_dataframe <- data.frame(
  Predictor = c("Treatment", "RiskGroup", "p53Status", "BRCAStatus"),
  HazardRatio = ovariancancer_HR,
  CI = ovariancancer_CI)

# Task 17: Create a boxplot based on the ovariancancer_dataframe
# Name the x-Axis Predictor and the y-Axis HazardRatio
# The ymin and ymax function should state the following: ymin = CI.2.5.., ymax = CI.97.5..
# Name the boxplot ovariancancer_boxplot and display it
ovariancancer_boxplot <- ggplot(ovariancancer_dataframe, aes(x = Predictor, y = HazardRatio)) +
geom_boxplot() +
geom_errorbar(
aes(ymin = CI.2.5.., ymax = CI.97.5..),
width = 0.2,
position = position_dodge(0.5)
) +
geom_hline(yintercept = 1, linetype = "dashed", color = "blue") +
labs(
    title = "Estimated Hazard Ratios",
    x = "Predictor",
    y = "Hazard Ratio"
) +
theme_minimal() +
theme(
axis.text.x = element_text(angle = 45, hjust = 1),
legend.position = "none")
print(ovariancancer_boxplot)
