library(testthat)

#load the dataset "cervical" from the NBLDA package
test_that("TASK1", {
  expect_equal(cervical["let-7g", "N5"], 493, tolerance=1e-3)
  expect_equal(cervical["miR-125b", "T8"], 19, tolerance=1e-3)
})

#create a DGEList object of "cervical" called "cerv0"
#compute normalization factors & save under "cerv0"
test_that("TASK2", {
  expect_equal(cerv0$samples["N29", "lib.size"], 8034, tolerance=1e-3)
  expect_equal(cerv0$samples["T18", "norm.factors"], 1.317218, tolerance=1e-3)
})

#set the "cutoff" to "1"
test_that("TASK3", {
  expect_equal(cutoff, 1, tolerance=1e-3)
})

#calculate the max CPM value for each gene
#store genes with a max CPM value below the cutoff under "drop"
test_that("TASK4", {
  expect_equal(sum(drop), 889, tolerance=1e-3)
})

#create a new DGEList object called "cerv" by excluding "drop"
#look at the number of genes left in "cerv"
test_that("TASK5", {
  expect_equal(dim(cerv), c(712, 58), tolerance=1e-3)
})

#extract the sample names of "cervical" into a variable called "sample_names"
test_that("TASK6", {
  expect_identical(sample_names[45], "T16")
})

#extract the first letter (N/T) of the sample names into a variable called "group"
test_that("TASK7", {
  expect_identical(group[29], "N")
  expect_identical(group[30], "T")
})

#convert the "group" vector into a numeric vector called "group_numeric"
#convert "N" to 1, "T" to 2
test_that("TASK8", {
  expect_equal(group_numeric[29], 1, tolerance=1e-3)
  expect_equal(group_numeric[30], 2, tolerance=1e-3)
})

#create an MDS plot with plotMDS() & specify the sample colors based on their groups
test_that("TASK9", {
  expect_equal(sum(MDS_plot$x), 4.180684e-15, tolerance=1e-3)
  expect_equal(sum(MDS_plot$y), -7.176551e-15, tolerance=1e-3)
})

#create a "design" matrix with model.matrix()
test_that("TASK10", {
  expect_equal(design["8", "groupT"], 0, tolerance=1e-3)
  expect_equal(design["50", "groupT"], 1, tolerance=1e-3)
})

#voom() "cerv" & "design" into a variable called "cervoom"
#generate a mean-variance plot
test_that("TASK11", {
  expect_equal(sum(cervoom$weights), 16342.2, tolerance=1e-3)
})

#fit the linear model into a variable called "fit"
test_that("TASK12", {
  expect_equal(sum(fit$sigma), 748.723, tolerance=1e-3)
})

#create a contrast matrix ("N" vs "T") called "contrast_matrix"
#set "levels" to the names of the coefficients in "fit"
test_that("TASK13", {
  expect_equal(contrast_matrix["groupN", 1], 1, tolerance=1e-3)
  expect_equal(contrast_matrix["groupT", 1], -1, tolerance=1e-3)
})

#fit the contrast model into a variable called "fit_contrast"
#apply eBayes() to "fit_contrast" & save under "fit_contrast"
test_that("TASK14", {
  expect_equal(fit_contrast$var.prior, 9.561106, tolerance=1e-3)
  expect_equal(sum(fit_contrast$F), 4621.087, tolerance=1e-3)
  expect_equal(sum(fit_contrast$p.value), 181.5087, tolerance=1e-3)
})

#extract the top miRNA with topTable()
#sort by the p-values
#assign the result to "top.table"
test_that("TASK15", {
  expect_identical(rownames(top.table),
               c("miR-7", "miR-125b", "miR-10b*", "miR-140-5p", "miR-143", "miR-205",
                 "Candidate-12-3p", "miR-944", "miR-125a-5p", "miR-21*"))
})