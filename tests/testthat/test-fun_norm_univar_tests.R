test_that("univar norm test", {
  suppressWarnings({
    res = fun_norm_univar_tests(iris[,1],colnames(iris)[1])
    expect_type(res,'double')
  })
})
