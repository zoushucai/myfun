#' @title Load Package
#' @description
#' 加载包,如果该包没有安装,则安装以后再加载
#' @param ... 一个包名向量或字符串
#' @param char 包名,字符串
#' @param install 尝试安装库中找不到的包
#' @param type 以二进制的形式安装, 或者 "source"
#' @param character.only 如果为TRUE，则p_load将只接受单个字符串，默认接受向量字符串
#' @return 返回值为空, 不可见
#' @seealso [pacman::p_load]
#' @export

fun_load = function ( ..., char, install = TRUE, type = "binary",
                    character.only = FALSE){

  if(!missing(char)){
    packages <- char
  }else if(character.only){
    packages <- eval(match.call()[[2]])
  }else{
    packages <- as.character(match.call(expand.dots = FALSE)[[2]])
  }


  if(length(packages) == 0){
    return(invisible())
  }


  # Attempt to load packages making note of which don't load
  loaded <- sapply(packages, p_load_single, install = install, type = type)
  # Give a warning if some packags couldn't be installed/loaded
  if(!all(loaded)){
    failed <- packages[!loaded]
    # TODO: We should make this more descriptive
    # Could it not load - or could it not install?
    warning("Failed to install/load:\n", paste(failed, collapse=", "))
  }

  return(invisible(loaded))
}


p_load_single <-
  function (package, install = TRUE, type = "binary"){
    # Try to load package
    if(suppressMessages(suppressWarnings(require(package, character.only = TRUE)))){
      return(TRUE)
    }
    # Loaded failed - attempt to install

    if(install){
      # 二进制安装
      install.packages(package,type = type)
      # Try to load again - return results
      return(suppressMessages(require(package, character.only = TRUE)))
    }

    # Couldn't load and we didn't want to install
    return(FALSE)
  }
