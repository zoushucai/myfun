#' @title 计算滞后阶数
#' @description
#' 计算滞后阶数,要小心,有很多函数需要转换,因为会删除 NA 值,这个函数不会
#' 不太清楚如何直接导入别人包中的函数,怕同名,弄个fun_前缀开始的函数,统一书写
#'
#' @inheritParams dplyr::lag
#' @seealso [dplyr::lag]
#' @export
fun_lag = dplyr::lag
