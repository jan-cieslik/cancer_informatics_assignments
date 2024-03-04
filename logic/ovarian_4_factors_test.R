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
  expect_equal(as.character(km_fit[["call"]][[1]]), "survfit")
})

# Task 6
test_that("OVC_6", {
  expect_equal(km_fit_participants, c(298, 302), tolerance=1e-3)
})

# Task 7
test_that("OVC_7", {
  expect_equal(km_fit_confint, 0.95, tolerance=1e-3)
})

# Task 8
test_that("OVC_8", {
  expect_equal(km_diff_p, 0.04147609, tolerance=1e-3)
})

# Task 9
test_that("OVC_9", {
  expect_equal(km_diff_chisq, 4.156457, tolerance=1e-3)
  expect_equal(km_diff_obs, c(85, 90), tolerance=1e-3)
  expect_equal(km_diff_exp, c(71.83919, 103.16081), tolerance=1e-3)
})

# Task 10
test_that("OVC_10", {
  expect_equal(ggsurvplot_graph[["plot"]][["labels"]][["x"]], "Time (Months)")
  expect_equal(ggsurvplot_graph[["plot"]][["labels"]][["y"]], "Survival Probability")
  expect_equal(ggsurvplot_graph[["plot"]][["labels"]][["title"]], "Kaplan-Meier Survival Curve")
  expect_equal(ggsurvplot_graph[["plot"]][["plot_env"]][["legend.labs"]], c("No Treatment", "Treatment"))
  expect_equal(ggsurvplot_graph[["plot"]][["plot_env"]][["palette"]], c("red",  "blue"))
  expect_equal(ggsurvplot_graph[["plot"]][["plot_env"]][["xlim"]], c(0, 36), tolerance=1e-3)
  expect_equal(ggsurvplot_graph[["plot"]][["plot_env"]][["ylim"]], c(0, 1), tolerance=1e-3)
})

# Task 11
test_that("OVC_11", {
  expect_true("survival" %in% (.packages()))
})

# Task 12
test_that("OVC_12", {
  expect_equal(as.character(ovariancancer_cox_model[["call"]])[2], "Surv(Time, Status) ~ Treatment + RiskGroup + p53Status + BRCAStatus")
})

# Task 13
test_that("OVC_13", {
  expect_equal(ovariancancer_cox_model[["coefficients"]][["Treatment"]], -0.3477277, tolerance=1e-3)
  expect_equal(ovariancancer_cox_model[["coefficients"]][["RiskGroup"]], -0.2326791, tolerance=1e-3)
  expect_equal(ovariancancer_cox_model[["coefficients"]][["p53Status"]], 0.2231011, tolerance=1e-3)
  expect_equal(ovariancancer_cox_model[["coefficients"]][["BRCAStatus"]], 0.2387607, tolerance=1e-3)
})

# Task 14
test_that("OVC_14", {
  expect_equal(ovariancancer_HR, c("Treatment" = 0.7062912,  "RiskGroup" = 0.7924078,  "p53Status" = 1.2499469, "BRCAStatus" = 1.2696746), tolerance=1e-3)
})

# Task 15
test_that("OVC_15", {
  expect_equal(ovariancancer_CI[1:8], c(0.5226504, 0.5867161, 0.9255977, 0.8931666, 0.9544567, 1.0702111, 1.6879550, 1.8048969), tolerance=1e-3)
})

# Task 16
test_that("OVC_16", {
  expect_equal(boxplot_data$HazardRatio, c(0.7062912, 0.7924078, 1.2499469, 1.2696746), tolerance=1e-3)
  expect_equal(boxplot_data$CI.2.5.., c(0.5226504, 0.5867161, 0.9255977, 0.8931666), tolerance=1e-3)
})

# Task 17
test_that("OVC_17", {
  expect_equal(ovariancancer_boxplot[["labels"]][["x"]], "Predictor")
  expect_equal(ovariancancer_boxplot[["labels"]][["y"]], "Hazard Ratio")
  expect_equal(ovariancancer_boxplot[["data"]][["Predictor"]], c("Treatment", "RiskGroup", "p53Status", "BRCAStatus"))
  expect_equal(ovariancancer_boxplot[["data"]][["HazardRatio"]], c(0.7062912, 0.7924078, 1.2499469, 1.2696746), tolerance=1e-3)
  expect_equal(ovariancancer_boxplot[["data"]][["CI.2.5.."]], c(0.5226504, 0.5867161, 0.9255977, 0.8931666), tolerance=1e-3)
  expect_equal(ovariancancer_boxplot[["data"]][["CI.97.5.."]], c(0.9544567, 1.0702111, 1.6879550, 1.8048969), tolerance=1e-3)
})