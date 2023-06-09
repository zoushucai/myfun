#' @title 进行单变量的正态分布检验
#' @order 2
#' @describeIn fun_normality_tests    进行单变量的正态分布检验, 提供几种不同类型的正态检验方法
#' - "Shapiro", see [stats::shapiro.test]
#' - "KS" , see [stats::ks.test]
#' - "AD" , see [nortest::ad.test]
#' - "Lillie", see [nortest::lillie.test]
#' - "SF", see [nortest::sf.test]
#' - "CVM", see [nortest::cvm.test]
#' - "JB", see [moments::jarque.test]
#' @param x 一个数值型向量
#' @param cn 一个字符串, 与 x 对应的字符串, 只用来修改 qq 图上的 title, 使得我们容易区分,这是那个变量的 qq 图而已
#' @return `fun_norm_univar_tests()` 返回一个矩阵, 行是对应正态分布检验的方法,列分别代表 P 值, 统计量,
#' 正态分布的判断结果, 结果为 1 表示接受原假设, 是正态分布.0 则相反
#'
#' @export
#' @examples
#' data(iris)
#' fun_norm_univar_tests(iris[,1],colnames(iris)[1])
#'
fun_norm_univar_tests <- function(x,cn="") {
  output <- matrix(NA, nrow = 7, ncol = 3)

  # Shapiro-Wilk test
  sw_test <- tryCatch(shapiro.test(x), error = function(e) e)
  if (inherits(sw_test, "error")) {
    output[1, ] <- rep(NA, 3)
  } else {
    output[1, 1] <- sw_test$statistic
    output[1, 2] <- sw_test$p.value
    output[1, 3] <- as.numeric(sw_test$p.value > 0.05)
  }

  # Kolmogorov-Smirnov test
  ks_test <- tryCatch(ks.test(x, "pnorm",mean(x),sd(x)), error = function(e) e)
  if (inherits(ks_test, "error")) {
    output[2, ] <- rep(NA, 3)
  } else {
    output[2, 1] <- ks_test$statistic
    output[2, 2] <- ks_test$p.value
    output[2, 3] <- as.numeric(ks_test$p.value > 0.05)
  }

  # Anderson-Darling test
  ad_test <- tryCatch(ad.test(x), error = function(e) e)
  if (inherits(ad_test, "error")) {
    output[3, ] <- rep(NA, 3)
  } else {
    output[3, 1] <- ad_test$statistic
    output[3, 2] <- ad_test$p.value
    output[3, 3] <- as.numeric(ad_test$p.value > 0.05)
  }

  # Lilliefors (Kolmogorov-Smirnov) test
  lillie_test <- tryCatch(lillie.test(x), error = function(e) e)
  if (inherits(lillie_test, "error")) {
    output[4, ] <- rep(NA, 3)
  } else {
    output[4, 1] <- lillie_test$statistic
    output[4, 2] <- lillie_test$p.value
    output[4, 3] <- as.numeric(lillie_test$p.value > 0.05)
  }

  # Shapiro-Francia test
  sf_test <- tryCatch(sf.test(x), error = function(e) e)
  if (inherits(sf_test, "error")) {
    output[5, ] <- rep(NA, 3)
  } else {
    output[5, 1] <- sf_test$statistic
    output[5, 2] <- sf_test$p.value
    output[5, 3] <- as.numeric(sf_test$p.value > 0.05)
  }

  # Cramer-von Mises test
  cvm_test <- tryCatch(cvm.test(x), error = function(e) e)
  if (inherits(cvm_test, "error")) {
    output[6, ] <- rep(NA, 3)
  } else {
    output[6, 1] <- cvm_test$statistic
    output[6, 2] <- cvm_test$p.value
    output[6, 3] <- as.numeric(cvm_test$p.value > 0.05)
  }

  # Jarque-Bera（JB）检验 -- moments 包中的函数
  jb_test = tryCatch(moments::jarque.test(x), error = function(e) e)
  if (inherits(jb_test, "error")) {
    output[7, ] <- rep(NA, 3)
  } else {
    output[7, 1] <- jb_test$statistic
    output[7, 2] <- jb_test$p.value
    output[7, 3] <- as.numeric(jb_test$p.value > 0.05)
  }


  ####### output #####
  colnames(output) <- c("Statistic", "P-value", "Normality")
  rownames(output) <- c("Shapiro", "KS", "AD", "Lillie", "SF", "CVM","JB")
  # 顺便输出 qq 图 -- qq 图可以检验任意分布,这里只检验正太分布
  qqnorm(x,main= paste0(cn," Normal Q-Q Plot"));qqline(x,col = 'red');
  return(output)
}
