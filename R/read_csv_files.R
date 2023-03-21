#' @title 读取所有符合要求的csv文件
#'
#' @description
#' 读取某个路径下的所有 csv 文件,并添加一列 symbol, 该列的内容是去除后缀的文件名
#' 只能读取 csv 文件
#' @inheritDotParams base::list.files
#' @return返回一个 data.table
#' @seealso [base::list.files()]
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

read_csv_files <- function(...){
  file_list <- list.files(...)

  # 如果没有找到符合条件的文件，则返回空数据框
  if (length(file_list) == 0) {
    return(data.table::data.table())
  }
  suffix ="\\.csv$"
  # 从文件名中提取数字部分作为symbol列的值
  #symbol_list <- gsub(suffix, "", basename(file_list))

  # 读取每个csv文件到数据框中，并在第一列添加symbol列
  data_list <- lapply(file_list, function(filename){
    data <- data.table::fread(file = filename)

    # 检查是否存在名为 'symbol' 的列
    if ("symbol" %in% colnames(data)) {
      warning(paste0('\n',filename," 中存在名为 'symbol' 的列,内容将被覆盖\n"))
    }

    # 后缀替换为空,当做变量赋值
    symbol <- gsub(suffix, "", basename(filename))
    data[, "symbol" := symbol]
  })

  # 合并所有数据框
  merged_data <- data.table::rbindlist(data_list, use.names = TRUE, fill = TRUE)
  return(merged_data)
}
