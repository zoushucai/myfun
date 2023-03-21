test_that("normality tests", {
  suppressWarnings({
    res = fun_normality_tests(iris)
    expect_type(res, "list")
  })

})
