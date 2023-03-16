#' @title 正太分布检验
#'
#' @param df 一个数据框, 会对数据框做数值型检查,只检查带数值型的列
#'
#' @return list, 返回一个 list, 每一列的正态分布检验结果存储在list 的元素中, 每个元素是一个矩阵
#' @export
#'
#' @examples
#' data(iris)
#' normality_tests(iris)
#'
normality_tests <- function(df) {
  # df: 待检验的数据向量,

  # 1.检查每一列是否为数字类型
  numeric_cols <- sapply(df, is.numeric)
  # 如果存在非数字类型的列，则过滤掉并发出警告
  if (sum(!numeric_cols) > 0) {
    non_numeric_cols <- names(df)[!numeric_cols]
    warning(paste("\n以下列不是数字类型：\n", paste(non_numeric_cols, collapse = ", "), '\n即上述列不做检验.\n'))
    df <- df[, numeric_cols]
  }

  # 2. 由于 R 的问题, 只能用普通的 numeric 来正太检验
  # 转换检查的数据对象类型
  df <- apply(df, 2, as.numeric)

  list_res = list()
  # 循环遍历每一列
  for (i in seq_len(ncol(df))) {
    cn = colnames(df)[i]
    list_res[[cn]] <- univar_norm_tests(df[, i],cn)
  }
  cat("\nNormality列表示: 1为正太分布,  0不是正太分布\n")
  return(list_res)
}


