library(testthat)

#load the data from data/cervical_survival.csv into a variable called "cervsurv"
test_that("TASK1", {
  expect_equal(cervsurv$Time[45], 47.901, tolerance=1e-3)
  expect_equal(cervsurv$Time[87], 30.707, tolerance=1e-3)
})

#create a Surv object called "sobj"
test_that("TASK2", {
  expect_equal(unname(sobj[2, 1]), 0.658, tolerance=1e-3)
  expect_equal(unname(sobj[53, 1]), 2.104, tolerance=1e-3)
})

#fit the Kaplan-Meier curves & assign the result to "km"
test_that("TASK3", {
  expect_equal(sum(km$time), 3823.035, tolerance=1e-3)
  expect_equal(sum(km$cumhaz), 58.72809, tolerance=1e-3)
})

#create a Kaplan-Meier plot with number at risk & assign the result to "km_plot"
test_that("TASK4", {
  expect_equal(sum(km_plot$data.survplot$surv), 71.82662, tolerance=1e-3)
  expect_equal(sum(km_plot$data.survtable$pct.risk), 195, tolerance=1e-3)
})

#fit the Kaplan-Meier curves with covariates & assign the result to "km_type"
test_that("TASK5", {
  expect_equal(sum(km_type$time), 3931.133, tolerance=1e-3)
  expect_equal(sum(km_type$cumhaz), 60.03156, tolerance=1e-3)
})

#create a Kaplan-Meier plot with number at risk and p-value & assign the result to "km_type_plot"
test_that("TASK6", {
  expect_equal(sum(km_type_plot$data.survplot$surv), 73.29364, tolerance=1e-3)
  expect_equal(sum(km_type_plot$data.survtable$pct.risk), 384, tolerance=1e-3)
})