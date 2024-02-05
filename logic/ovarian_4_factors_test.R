library(testthat)

#Task 1
test_that("OVC_1", {
  expect_equal(sum(simulated_data$Time), 11066.6, tolerance=1e-3) 
})

#Task 2
test_that("OVC_2", {
  expect_equal(sum(test_head$Time), 126.4441, tolerance=1e-3) 
})

#Task 3
test_that("OVC_3", {
  expect_equal(colnames(simulated_data),
               c("Treatment",  "RiskGroup",  "p53Status",  "BRCAStatus", "Status", "Time" )) 
})


#Logic Test for Exercise 1+2:


# Attempt Exercise 1+2
simulated_data <- read.csv("ovarian_4_factors.csv")
head_of_data <- head(simulated_data, 5)

#Evaluate Exercise 1+2:


# Expected Results for Exercise 1+2
expected_head <- head(simulated_data, 5)

# Logic Test for Exercise 1+2
identical(head_of_data, expected_head)

# Logic Test for Exercise 3:


# Attempt Exercise 3
simulated_data <- read.csv("ovarian_4_factors.csv")
expected_columns <- c("Treatment", "RiskGroup", "ERStatus", "HER2Status", "Status", "Time")
result <- all(expected_columns %in% colnames(simulated_data))


# Evaluate Exercise 3:


# Expected Results for Exercise 3
expected_result <- TRUE

# Logic Test for Exercise 3
identical(result, expected_result)