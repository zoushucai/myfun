#' @title 把R 中的矩阵或数据框对象转变为 latex 的矩阵格式
#' @param x  矩阵或数据框对象
#' @param digits, 保留的小数
#' @param ... 其余的参数
#'
#' @return 输出 latex 矩阵环境
#' @export
#'
#' @examples
#' fun_bmatrix(iris[1:5,])
#'
fun_bmatrix = function(x, digits=NULL, ...) {
  default_args = list(include.colnames=FALSE, only.contents=TRUE,
                      include.rownames=FALSE, hline.after=NULL, comment=FALSE,
                      print.results=FALSE)
  passed_args = list(...)
  calling_args = c(list(x=xtable::xtable(x, digits=digits)),
                   c(passed_args,
                     default_args[setdiff(names(default_args), names(passed_args))]))
  cat("\\begin{bmatrix}\n",
      do.call(xtable::print.xtable, calling_args),"\\end{bmatrix}\n")
}
