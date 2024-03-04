# Task 1: Load the simulated ovarian cancer dataset

# Task 2: Display the first five rows of the dataset

# Task 3: Check if the dataset has the expected columns

# or using names()

# Task 4: Load library survival and survminer

# Task 5: Create a Kaplan-Meier survival curve using the surv_fit function and save the data as km_fit

# Task 6: Extract the number of participants from the Kaplan-Meier curve and save the data as km_fit_participants

# Task 7: Extract also conf.int, n.risk, n.event and n.censor. Save the data as km_fit_confint, km_fit_nrisk, km_fit_nevent and km_fit_ncensor
# conf.int: Attribute contains the confidence intervals for the survival probabilities at each time point. These intervals provide a range within which the true survival probability is likely to lie with a certain level of confidence (e.g., 95%).
# n.risk: This represents the number of individuals at risk at each time point. At the beginning of the study, this is equal to the total number of individuals in the study. As the study progresses and individuals experience the event of interest or are censored, this number decreases.
# n.event: This represents the number of individuals who experienced the event of interest (e.g., death) at each time point. This is also called the number of failures.
# n.censor: This represents the number of individuals who were censored at each time point. Censoring occurs when an individual is lost to follow-up or withdraws from the study before experiencing the event of interest.

# Task 8: Extract the p-value using the survdiff function, which performs a log-rank test for comparing survival curves between treatment groups and save the data as km_diff.

# Task 9: Extract also chisq, obs and exp. Save the data as km_diff_chisq, km_diff_obs and km_diff_exp
# chisq: The test statistic, which is a measure of the difference in survival distributions between the groups. A larger test statistic indicates a greater difference in survival between the groups. 
# observed: The observed number of events (e.g., deaths) in each group.
# expected: The expected number of events in each group under the null hypothesis.

# Task 10: Set the plotting parameters for the Kaplan-Meier plot. Define the x-axis label as "Time (Months)" and the y-axis label as "Survival Probability". 
# Set the main title of the plot as "Kaplan-Meier Survival Curve". 
# Limit the x-axis to the range [0, 36] months and the y-axis to the range [0, 1].
# Set the colour for the treatment group to "blue" and for the no treatment group to "red"
# Add the p-value in the plot
# Create a data containing the plot and name it ggsurvplot_graph

# Task 2.0 Cox Regression + Boxplot + HR's
# Next we want to access the hazard ratios for the different factors and their impact one the potential outcome (event death yes or no)
# Therefore we will use the coxph function from the survival package
# The Cox proportional hazards model is a semi-parametric model that allows for the estimation of the hazard ratio (the risk of an event occurring at a given time)
# Task 11: Load library survival 

# Task 12: Fit a Cox proportional hazards model using the coxph function. 
# Use status as the possible event and Treatment, RiskGroup, p53Status and BRCAStatus as possible predictors.
# Name it ovariancancer_cox_model.

# Task 13: Extract the coefficients for each predictor.
# The coefficients of the model represent the estimated log hazard ratios (log HR) for each predictor variable. 

# Task 14:  The hazard ratios represent the ratio of the hazard rates between two groups or levels of a categorical variable. 
# They can be calculated by exponentiating the coefficients of the model.
# Therefore we will use the coef function extracting the coefficients and then exponentiating them using the exp(coef( function.
# Name the outcoming data ovariancancer_HR and print the results.

# Task 15: Next we also want to extract the confidence intervals from the ovariancancer_cox_model object using the exp(confint( function.
# Name the outcoming data ovariancancer_CI and print the results. 

# Task 16: Now we want to create a dataframe containing predictors [Predictor], hazard ratio [HazardRatio] and confidence intervals [CI].
# We name it ovariancancer_dataframe

# Task 17: Create a boxplot based on the ovariancancer_dataframe
# Name the x-Axis Predictor and the y-Axis HazardRatio
# The ymin and ymax function should state the following: ymin = CI.2.5.., ymax = CI.97.5..
# Name the boxplot ovariancancer_boxplot and display it