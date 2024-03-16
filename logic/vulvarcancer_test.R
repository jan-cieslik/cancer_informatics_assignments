library(testthat)

#Task 1
test_that("VC_1", {
  expect_true("randomForest" %in% (.packages()))
})

#Task 2
test_that("VC_2", {
  expect_equal(vulvarcancer$Treatment[1:10], c(0, 0, 0, 0, 1, 1, 0, 0, 1, 0), tolerance=1e-3) 
})

#Task 3
test_that("VC_3", {
  expect_equal(data_test$Treatment[1:10], c(1, 0, 1, 1, 1, 0, 0, 1, 1, 1), tolerance=1e-3)
  expect_equal(data_train$Treatment, c(0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1), tolerance=1e-3) 
})

#Task 4
test_that("VC_4", {
  expect_equal(predictors, c("Treatment", "Lichen_ruber", "VIN", "MorbusPaget", 
                             "HPV16_18", "Smoking", "Obesity", 
                             "More_than_3_Sexual_Partners", "Lymphovascular_Invasion", 
                             "Perineural_Invasion", "HPV_Vaccination", "Time"), tolerance=1e-3)
  expect_equal(outcome, "Status", tolerance=1e-3) 
})

#Task 5
test_that("VC_5", {
  expect_equal(preProcValues[["mean"]][["Treatment"]], 0.4615385, tolerance=1e-3)
  expect_equal(preProcValues[["mean"]][["Lichen_ruber"]], 0.5384615, tolerance=1e-3)
  expect_equal(train_transformed$Treatment[1:5], c(-0.8894992, -0.8894992, -0.8894992, -0.8894992,  1.0377490), tolerance=1e-3)
  expect_equal(test_transformed$Treatment[1:5], c(1.0377490, -0.8894992,  1.0377490,  1.0377490,  1.0377490), tolerance=1e-3) 
})

#Task 6
test_that("VC_6", {
  expect_equal(rf_vulvarcancer[["call"]][["ntree"]], 500, tolerance=1e-3) 
})

#Task 7
test_that("VC_7", {
  expect_equal(confusion_vulvarcancer[["overall"]][["Accuracy"]], 0.7737226, tolerance=1e-3)
  expect_equal(data_train$Treatment, c(0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1), tolerance=1e-3) 
})

#Task 8
test_that("VC_8", {
  expect_equal(plot_vulvarcancer[1], 0.1136992, tolerance=1e-3) 
})

