
library(usethis)
usethis::use_build_ignore("devtools_history.R")   # 把这个文件进行忽略

usethis::use_news_md() #记录每个版本的增加的功能或者变更情况

usethis::use_readme_rmd()

devtools::build_readme()

usethis::use_gpl3_license()


library(usethis,devtools)

use_package("rstudioapi")

use_import_from("crayon", "blue")  # 从包中导入函数
use_import_from("crayon", "bold")  # 从包中导入函数
use_import_from("crayon", "cyan")  # 从包中导入函数
use_import_from("crayon", "green")  # 从包中导入函数
use_import_from("pacman", "p_load")  # 从包中导入函数


use_r("set_wd")   # 编写函数
use_r("p_load")   # 导入别人包中的函数



# 3.4 生成函数帮助文档
devtools::document()  #
help(set_wd)  # 可以利用 ?函数名  或 help(函数名)  查看生成的帮助文档, 可以进入该函数的Rd文件,点击 预览按钮 查看
help(p_load)
###########  4 加载并测试你的函数
devtools::load_all() # 加载该包的所有函数,然后再命令行中进行函数测试


# 检查
devtools::check()
