test_that("multiplication works", {
  path = system.file("extdata", package = "myfun")
  df = read_csv_files(path,full.names = TRUE)
  df_head = head(df,10)
  df2 = add_week_month(df_head, '日期')
  expect_s3_class(df, "data.frame")
  expect_s3_class(df2, "data.frame")
})

