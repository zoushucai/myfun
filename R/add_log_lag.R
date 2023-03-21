#' @title 计算对数收益率以及把收益率滞后 11 个阶数
#' @describeIn add_log_lag 为给定的数据框中指定的列, 计算对数收益率以及把收益率滞后 11 个阶数
#'
#' @param df  数据框
#' @param col_name  字符串,指定的列
#' @param lag_order 滞后的阶数,完全根据计算好的收益率来进行滞后
#' @inheritDotParams TTR::ROC -x
#'
#' @return 返回一个新的数据框, 在源数据上进行添加操作
#' @export
#'
#' @examples
#' myfun_example <- function(path = NULL) {
#'   if (is.null(path)) {
#'     system.file("extdata", package = "myfun")
#'   } else {
#'     system.file("extdata", path, package = "myfun", mustWork = TRUE)
#'   }
#' }
#' path = myfun_example()
#' df = read_csv_files(path,full.names = TRUE)
#' df2 = add_log_lag(df,'收盘')
#'
#'
add_log_lag = function(df, col_name,lag_order= c(1:5L,10L,21L, 42L, 63L, 126L,  252L), ...){
  new_name = paste0(col_name, '_log')
  df[[new_name]] = TTR::ROC(df[[col_name]], ...)
  # lag_order
  for (i in lag_order) {
    df[[paste0(new_name,'_lag_',i)]] = dplyr::lag(df[[new_name]], i)
  }
  return(df)
}

#' @describeIn add_log_lag 为给定列,只进行滞后阶数,并返回合并后的数据
#' @export
add_lag = function(df, col_name,lag_order= c(1:5L,10L,21L, 42L, 63L, 126L,  252L), ...){
  # lag_order
  for (i in lag_order) {
    df[[paste0(col_name,'_lag_',i)]] = dplyr::lag(df[[col_name]], i)
  }
  return(df)
}


#' @describeIn add_log_lag 为给定列只计算对数收益率,并返回合并后的数据
#' @export
add_log = function(df, col_name, ...){
  new_name = paste0(col_name, '_log')
  df[[new_name]] = TTR::ROC(df[[col_name]], ...)
  return(df)
}



