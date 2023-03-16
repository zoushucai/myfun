test_that("normality tests", {
  res = normality_tests(iris)
  expect_type(res, "list")
})
