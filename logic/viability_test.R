library(testthat)

#load data from data/sanger.csv into a variable called "data"
test_that("VIAB_1", {
  expect_equal(sum(data$dose), 267.3134, tolerance=1e-3) 
})

#create a subset called MCF7 and MDA
#containing only data from MCF7 or MDA-MB-231
test_that("VIAB_2", {
  expect_equal( sum(MCF7$viability), 115.4889, tolerance=1e-3) 
  expect_equal( sum(MDA$viability), 115.5877, tolerance=1e-3) 
})

#subset the data further to only contain TAMOXIFEN data with a dose of 5
#call the new variables MCF7_Tamoxifen and MDA_Tamoxifen
test_that("VIAB_3", {
  expect_equal( sum(MCF7_Tamoxifen$viability), 3.236021, tolerance=1e-3) 
  expect_equal( sum(MDA_Tamoxifen$viability), 4.755122, tolerance=1e-3) 
})

#calculate the mean "viability" difference between the two groups previously defined
#assign the result to viability_diff
test_that("VIAB_4", {
  expect_equal(abs(viability_diff), 0.1912291, tolerance=1e-3) 
})

#perform a t test using t.test() between the two groups previously defined
#save the response to viability_ttest
test_that("VIAB_4", {
  expect_equal(viability_ttest$p.value, 1.716086e-05, tolerance=1e-3) 
})
