# Task 1: Load the simulated ovarian cancer dataset
simulated_data <- read.csv("ovarian_4_factors.csv")

# Task 2: Display the first five rows of the dataset
test_head <- head(simulated_data, 5)

# Task 3: Check if the dataset has the expected columns
column_names <- colnames(simulated_data)
print(column_names)

# or using names()
column_names <- names(simulated_data)
print(column_names)
