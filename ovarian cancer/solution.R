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

# Task 5: Create a Kaplan-Meier survival curve and save the data as km_fit
km_fit <- surv_fit(Surv(Time, Status) ~ Treatment, data = simulated_data)

# Task 6: Extract the number of participans from the Kaplan-Meier curve
num_participants <- km_fit$n

# Task 7: Extract the p-value using the survdiff function, which performs a log-rank test for comparing survival curves between treatment groups and save the data as km_diff.
km_diff <- survdiff(Surv(Time, Status) ~ Treatment, data = simulated_data)
km_diff_p <- km_diff$pvalue

# Task 8: Set the plotting parameters for the Kaplan-Meier plot. Define the x-axis label as "Time (Months)" and the y-axis label as "Survival Probability". 
# Set the main title of the plot as "Kaplan-Meier Survival Curve". 
# Limit the x-axis to the range [0, 36] months and the y-axis to the range [0, 1].
# Set the colour for the treatment group to "blue" and for the no treatment group to "red"
plot(km_fit, col = c("red", "blue"), lwd = 2, xlab = "Time (Months)", ylab = "Survival Probability",
     main = "Kaplan-Meier Survival Curve", xlim = c(0, 36), ylim = c(0, 1),
     xaxs = "i", yaxs = "i", las = 1)



p <- ggsurvplot(km_fit)

# Task 9: Create a legend in the bottom-right corner of the plot. 
# Label the treatment group as "Treatment" and the no treatment group as "No Treatment". 
# Use the colors blue and red for the respective groups.
#legend("bottomright", legend = c("Treatment", "No Treatment"), col = c("blue", "red"), lwd = 2)

# Task 10: Cox Regression + Boxplot + HR's