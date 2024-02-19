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

#Task 4
test_that("OVC_4", {
  expect_true("survival" %in% (.packages()))
})

#Task 5
test_that("OVC_5", {
  expect_true(inherits(km_fit, "survfit"))
})

# Task 6
test_that("OVC_6", {
  expect_equal(num_participants, c(298, 302), tolerance=0)
})

# Task 7
test_that("OVC_7", {
  expect_equal(km_diff$pvalue, 0.04147609, tolerance=1e-3)
})

# Task 8
test_that("OVC_8", {
  expect_equal(par("xlab"), "Time (Months)")
  expect_equal(par("ylab"), "Survival Probability")
  expect_equal(par("main"), "Kaplan-Meier Survival Curve")
  expect_equal(attr(km_fit, "col"), c("red", "blue"))
  expect_equal(attr(km_fit, "call")$xlim, c(0, 36))
  expect_equal(attr(km_fit, "call")$ylim, c(0, 1))
})

# Task 9