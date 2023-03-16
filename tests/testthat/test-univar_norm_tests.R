test_that("univar norm test", {
  res = univar_norm_tests(iris[,1],colnames(iris)[1])
  expect_type(res,'double')
})
