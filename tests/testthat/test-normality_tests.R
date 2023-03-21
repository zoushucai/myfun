test_that("normality tests", {
  suppressWarnings({
    res = normality_tests(iris)
    expect_type(res, "list")
  })

})
