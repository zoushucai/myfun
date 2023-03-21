# myfun 0.0.1.2


- `normality_tests` 正态分布检验, 根据输入的数据框, 会对数据框做数值型检查,只检查带数值型的列 

- `univar_norm_tests` 单变量的正态分布检验

- `read_csv_files` 读取一个路径下符合要求的所有 csv 文件, 并以文件名作为单独的一列, 这列的列名为`symbol` ,把这些数据全部以行合并的方式,返回一个 `data.table`

- `add_week_month` 根据数据框中指定的列, 如果这个列是日期,则会根据日期返回周几以及月份,并追加到原来的数据中

- `set_wd` 设置工作目录

- `p_load`  来自`pacman::p_load`, 加载所有的包,如果包不存在则安装,安装后重新加载


# myfun 0.0.1

* Added a `NEWS.md` file to track changes to the package.

* 自己的小函数,以后慢慢添加


