% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_log_lag.R
\name{add_log_lag}
\alias{add_log_lag}
\alias{add_lag}
\alias{add_log}
\title{计算对数收益率以及把收益率滞后 11 个阶数}
\usage{
add_log_lag(
  df,
  col_name,
  lag_order = c(1:5L, 10L, 21L, 42L, 63L, 126L, 252L),
  ...
)

add_lag(df, col_name, lag_order = c(1:5L, 10L, 21L, 42L, 63L, 126L, 252L), ...)

add_log(df, col_name, ...)
}
\arguments{
\item{df}{数据框}

\item{col_name}{字符串,指定的列}

\item{lag_order}{滞后的阶数,完全根据计算好的收益率来进行滞后}

\item{...}{
  Arguments passed on to \code{\link[TTR:changes]{TTR::ROC}}
  \describe{
    \item{\code{n}}{Number of periods to use.}
    \item{\code{type}}{Compounding type; either \code{"continuous"} (the default) or
\code{"discrete"}.}
    \item{\code{na.pad}}{Should periods prior to \code{n} be appended?  Default is
\code{TRUE}.}
  }}
}
\value{
返回一个新的数据框, 在源数据上进行添加操作
}
\description{
计算对数收益率以及把收益率滞后 11 个阶数
}
\section{Functions}{
\itemize{
\item \code{add_log_lag()}: 为给定的数据框中指定的列, 计算对数收益率以及把收益率滞后 11 个阶数

\item \code{add_lag()}: 为给定列,只进行滞后阶数,并返回合并后的数据

\item \code{add_log()}: 为给定列只计算对数收益率,并返回合并后的数据

}}
\examples{
myfun_example <- function(path = NULL) {
  if (is.null(path)) {
    system.file("extdata", package = "myfun")
  } else {
    system.file("extdata", path, package = "myfun", mustWork = TRUE)
  }
}
path = myfun_example()
file_list = list.files(path, pattern = '\\\\.csv$',full.names = TRUE)
df = read_csv_files(file_list)
df2 = add_log_lag(df,'收盘')


}
