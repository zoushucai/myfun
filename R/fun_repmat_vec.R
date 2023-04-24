#' @title 把向量进行整体填充为矩阵.
#'
#' @description
#' 由于经常使用向量与矩阵混合计算, 会出现填充问题, 为了更加准确,
#' 建议先把向量转为矩阵以后,再去计算,这样可靠一些. 这个函数参考 matlab 中的 repmat 函数
#' 对向量进行整体的填充
#'
#' @describeIn fun_repmat 把向量作为整体进行填充,传递的 x 必须是向量

#'
#' @param  x  必须是一个向量, 在 \code{fun_repmat_vec} 中必须是向量, 在\code{fun_repmat} 中必须是矩阵
#' @param nrow  数字, 行数
#' @param ncol 数字, 列数
#' @param byrow  默认是FALSE , 即把传入的 向量 x 看做列向量为整体进行填充, 如果是 TRUE,表示把向量 x 看做行向量为整体进行填充
#'
#' @return 返回一个矩阵
#' @export
#'
#' @examples
#' fun_repmat_vec(c(1:3),2,4)
#' fun_repmat_vec(c(1:3),4,2,byrow = TRUE)
#'
#' fun_repmat(matrix(c(1:6),2,3), 2,4)
fun_repmat_vec <- function(x, nrow, ncol, byrow = FALSE) {
  if (!is.vector(x)) {
    stop("x must be a vector")
  }
  repeated_vec <- rep(x, times = nrow * ncol)

  if (byrow) {
    result <- matrix(repeated_vec, nrow = nrow, ncol = ncol * length(x), byrow = TRUE)
  } else {
    result <- matrix(repeated_vec, nrow = nrow * length(x), ncol = ncol, byrow = FALSE)
  }

  return(result)
}


#' @describeIn fun_repmat 把矩阵作为整体进行填充, 传递的 x 必须是矩阵
#' @export
#'
fun_repmat <- function(x, nrow, ncol) {
  if(!is.matrix(x)){ stop("x must be a matrix") }

  result = kronecker(matrix(1, nrow = nrow, ncol = ncol), x)

  return(result)
}
