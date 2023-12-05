# 解决喵崽的QSignApi自动崩溃问题的linux脚本

### 请配合https://gitee.com/touchscale/Qsign 使用

#### 介绍
喵崽是一款很好用的原神QQ机器人，但是其使用的ICQQ常有问题，为了解决ICQQ的问题，需要自建API（https://gitee.com/touchscale/Qsign）。

但是，高版本的ICQQ使用的API经常崩溃，换成低版本以后又会登录不上，故写脚本自动重启之。
https://gitee.com/touchscale/Qsign/issues/I8GLZN  中提供了windows的重启方式，但是没有其他操作系统的做法。
本脚本适用于ubuntu，其他linux系统或许也可用，自己试试吧。


#### 安装教程

克隆仓库或下载monitor_app.sh文件，配置好变量

chmod +x monitor_app.sh #赋予可执行权限

su #切换到root用户

./monitor_app.sh #开始运行

#### 变量配置说明

修改monitor_app.sh中的路径（dir）为你的Qsign所在的正确位置

修改monitor_app.sh中的版本（version）为你需要的版本号

检测间隔可以自行修改，默认10秒一次

在screen中运行脚本（推荐）, 或者用别的喜欢的方式把脚本挂在后台运行即可

#### 参与贡献

1.  你自己随便改就行



#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
