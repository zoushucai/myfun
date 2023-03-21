#' @title  根据给定数据框中的日期列,添加月份和周几
#'
#' @param df  数据框
#' @param col_name  字符串,指定的日期列名
#' @param format  指定日期列的格式, 同as.Date
#' @param ...   同as.Date
#'
#' @return  在原有的数据集上增加两列,weekdays,months 列且为因子
#'
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
#' head(df)
#'
#' df_head = head(df,10)
#' df2 = add_week_month(df_head, '日期')
#' head(df2)
#'
add_week_month <- function(df, col_name, format ="%Y-%m-%d",...) {
  # 检查传入的数据框和列名是否合法
  if (!is.data.frame(df)) {
    stop("请传入一个数据框")
  }
  # 检查指定列是否存在于数据框中
  col_names = colnames(df)
  if (!(col_name %in% col_names)) {
    stop("Specified column not found in data frame")
  }

  # 如果是字符串类型，尝试转换为日期格式
  if ( is.character(df[[col_name]]) || is.Date(df[[col_name]]) ) {
    # 尝试将列转换为日期格式
    tryCatch({
      df[[col_name]] = as.Date(df[[col_name]] , format = format, ...)
    },error = function(e) {
      stop("列不是日期或者日期字符串格式不正确")
    })

  } else {
    # 如果不是字符串或日期类型，则返回错误
    stop("Specified column is not formatted as a string or date")
  }
  #过滤时间戳,根据日期获取对应的星期和月份

  # 检查指定列是否存在于数据框中
  if ( "weekdays" %in% col_names ) {
    warning("数据框中已有 weekdays 列,将被覆盖")
  }

  # 检查指定列是否存在于数据框中
  if ( "months" %in% col_names ) {
    warning("数据框中已有 months 列,将被覆盖")
  }
  # 提取星期和月份
  #weekday <- lubridate::wday(data[[column_name]], label = FALSE) # 星期日为 1
  #month <- lubridate::month(data[[column_name]], label = FALSE)

  df[["weekdays"]] <- format(df[[col_name]], "%u")# 星期日为 7
  df[["months"]] <- format(df[[col_name]], "%m")
  df[["weekdays"]] = as.factor(df[["weekdays"]])
  df[["months"]] = as.factor(df[["months"]])
  return(df)
}
