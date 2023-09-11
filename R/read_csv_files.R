#' @title 读取所有符合要求的csv/xlsx 文件
#' @description
#' 读取所有符合要求的csv/xlsx 文件, 并添加一列列名为 `_file_name`, 该列名是读取文件的文件名(包含后缀)
#' @describeIn read_files 读取给定的所有 csv and xlsx 文件
#' @param file_list  一个 csv or xlsx 的文件向量, 一般由 `list.files()` 产生
#' @param ...  传递给读取 csv/xlsx 的函数的值
#' @return 返回一个 data.table
#' @seealso [base::list.files()] [myfun::read_csv_files()] [myfun::read_xlsx_files]
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
#' file_list = list.files(path, pattern = '\\.csv$',full.names = TRUE)
#' df = read_csv_files(file_list)
#' head(df)
#'
#' file_list = list.files(path, pattern = '\\.xlsx$',full.names = TRUE)
#' df = read_xlsx_files(file_list)
#' head(df)
#'
#' file_list = list.files(path, pattern = '(\\.xlsx$)|(\\.csv)',full.names = TRUE)
#' df = read_files(file_list)
#' head(df)
read_files <- function(file_list, ...){

  # 如果没有找到符合条件的文件，则返回空数据框
  if (length(file_list) == 0) {
    return(data.table::data.table())
  }

  data_list <- lapply(file_list, function(filename){
    file_extension <- tools::file_ext(filename)  # 获取文件扩展名

    if (file_extension == "xlsx") {
      data <- data.table::as.data.table(readxl::read_xlsx(path = filename, ...))
    } else if (file_extension == "csv") {
      data <- data.table::fread(file = filename, ...)
    } else {
      stop("Unsupported file format: ", file_extension)
    }

    # 检查是否存在名为 '_file_name' 的列
    if ("_file_name" %in% colnames(data)) {
      warning(paste0('\n',filename," 中存在名为 'symbol' 的列,内容将被覆盖\n"))
    }
    filename = basename(filename)
    # filename <- tools::file_path_sans_ext(basename(filename))
    data[, "_file_name" := filename]
  })

  # 合并所有数据框
  merged_data <- data.table::rbindlist(data_list, use.names = TRUE, fill = TRUE)
  return(merged_data)
}

#' @describeIn read_files 读取给定的所有 xlsx 文件,采用的是\code{readxl::read_xlsx(path = filename)}来读取
#' @export
read_xlsx_files <- function(file_list, ...){
  file_list <- file_list[grepl("\\.xlsx$", file_list)]

  # 如果没有找到符合条件的文件，则返回空数据框
  if (length(file_list) == 0) {
    return(data.table::data.table())
  }
  # 调用通用的 read_files 函数来读取和合并数据
  merged_data = read_files(file_list, ...)
  return(merged_data)
}


#' @describeIn read_files 读取给定的所有 csv 文件, 采用的是\code{data.table::fread(file = filename)} 来读取
#' @export
read_csv_files <- function(file_list, ...){
  file_list <- file_list[grepl("\\.csv$", file_list)]

  # 如果没有找到符合条件的文件，则返回空数据框
  if (length(file_list) == 0) {
    return(data.table::data.table())
  }
  # 调用通用的 read_files 函数来读取和合并数据
  merged_data = read_files(file_list, ...)
  return(merged_data)
}


