devtools::document()  #


library(usethis)
usethis::use_build_ignore("devtools_history.R")   # 把这个文件进行忽略

usethis::use_news_md() #记录每个版本的增加的功能或者变更情况

usethis::use_readme_rmd()

devtools::build_readme()

usethis::use_gpl3_license()
usethis::use_data_raw()

library(usethis,devtools)

use_package("rstudioapi")
use_package("nortest")
use_package("stats")
use_package("xtable")

use_import_from("crayon", "blue")  # 从包中导入函数
use_import_from("crayon", "bold")  # 从包中导入函数
use_import_from("crayon", "cyan")  # 从包中导入函数
use_import_from("crayon", "green")  # 从包中导入函数
use_import_from("pacman", "p_load")  # 从包中导入函数

use_import_from("nortest", "ad.test")  # 从包中导入函数
use_import_from("nortest", "lillie.test")  # 从包中导入函数
use_import_from("nortest", "sf.test")  # 从包中导入函数
use_import_from("nortest", "cvm.test")  # 从包中导入函数
use_import_from("lubridate", "is.Date")  # 从包中导入函数
use_import_from("lubridate", "is.Date")  # 从包中导入函数
use_import_from("dplyr", "lag")  # 从包中导入函数

use_import_from("TTR", "ROC")  # 从包中导入函数
use_import_from("readxl", "read_xlsx")
use_import_from("psych", c("describe","describeBy"))  # 从包中导入函数



usethis::use_data_table()
use_package("data.table")

use_import_from("stats", c("ks.test","shapiro.test"))
usethis::use_import_from("moments","jarque.test")

use_import_from("stats", c("qqline","qqnorm",'sd'))

usethis::use_import_from("utils","install.packages")

use_r("set_wd")   # 编写函数
use_r("p_load")   # 导入别人包中的函数
use_r("normality_tests")   # 导入别人包中的函数
use_r("univar_norm_tests")   # 导入别人包中的函数

use_r("read_csv_files")   # 编写函数
use_r("add_week_month")
use_r("set_wd")
use_r("add_log_lag")

use_r("fun_describe")
use_r("fun_describeBy")

use_r("fun_repmat_vec")
use_r("fun_repmat")

use_r("fun_describeBy")


use_r("test")
use_r("bmatrix")




# 3.4 生成函数帮助文档
devtools::document()  #x



help(set_wd)  # 可以利用 ?函数名  或 help(函数名)  查看生成的帮助文档, 可以进入该函数的Rd文件,点击 预览按钮 查看
help(p_load)

help(normality_tests)
help(fun_lag)
help(fun_ROC)
help(read_csv_files)
help(fun_repmat)

###########  4 加载并测试你的函数
devtools::load_all() # 加载该包的所有函数,然后再命令行中进行函数测试



normality_tests(iris)
univar_norm_tests(iris[,4],'ss')



########## 5.1 可能需要进行测试
#usethis::use_testthat() # 初始化 测试文件夹

use_test("normality_tests")  # 类似 use_r(), 只不过它创建的是一个测试文件,然后书写你要测试的函数
use_test("univar_norm_tests")
library(usethis,devtools)

devtools::test()
#' @inherit pacman::p_load


path = myfun_example()
df = read_csv_files(path, pattern = '\\.csv$',full.names = TRUE)
head(df)
df
df[, c("_file_name") := NULL ]
library(data.table)
fwrite(df, file=paste0(path,"/000001.csv"),bom=T)

library(writexl)
write_xlsx(df, path=paste0(path,"/000001.xlsx"))



path1 = "/Users/zsc/Desktop/未命名文件夹/Fund_副本/FundSummary/上市基金基本信息_19980407_20230530"
path2 = "/Users/zsc/Desktop/未命名文件夹/Fund_副本/FundSummary/基金主体信息表_19980327_20230530"
path3 = "/Users/zsc/Desktop/未命名文件夹/Fund_副本/FundSummary/基金代码信息表_19980327_20230530"

df1 = read_xlsx_files(path = path1, pattern = "\\.xlsx$", full.name)
df2 = read_xlsx_files(path = path2, pattern = "\\.xlsx$")
df3 = read_xlsx_files(path = path3, pattern = "\\.xlsx$")

use_git()
