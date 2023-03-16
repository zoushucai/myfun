#' @title Set the working directory. If not, create the working directory. You cannot create the directory recursively
#'
#' @param path NULL (default) or a specific path. Default is to extract the path of the currently opened file (usually .R or .Rmd) using the rstudioapi::getSourceEditorContext function.
#' @param ask  TRUE or FALSE (default). If TRUE, you can select a folder with the prompt of a dialog.
#'
#' @return Invisibly return the path.
#' @export
#'
#' @examples
#' ## Not run:
#' d = getwd()
#' m = tempdir()
#' set_wd(m)
#' set_wd(d)
set_wd = function (path = NULL, ask = FALSE) {
  # ask 参数提供一个选择文件的弹窗
  is.windows = ifelse(Sys.info()[["sysname"]] == "Windows",
                      TRUE, FALSE)
  if (is.null(path)) {
    tryCatch({
      if (ask) {
        if (is.windows)
          path = iconv(rstudioapi::selectDirectory(),
                       from = "UTF-8", to = "GBK")
        else path = rstudioapi::selectDirectory()
      }
      else {
        path = dirname(rstudioapi::getSourceEditorContext()$path)
      }
    }, error = function(e) {
      message("Your RStudio version is: ", rstudioapi::getVersion(),
              "\n")
      message("Please update RStudio to the latest version:\n",
              "https://rstudio.com/products/rstudio/download/preview/\n")
    })
  }

  if (length(path) > 0) {
    if (!dir.exists(path)) {
      cat(paste0("try create dir: ", crayon::green(crayon::bold(path)), '\n' ))
      dir.create(path = path)
      if (dir.exists(path)) {
        cat("=== create dir success ====\n")
      }else{
        invisible(path)
      }
    }
    setwd(path)
    cat(paste0("Set working directory to: ", crayon::cyan(crayon::bold(getwd())), '\n'))
  }
  invisible(path)
}


