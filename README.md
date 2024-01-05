# 解决喵崽的QSignApi自动崩溃问题的linux脚本

### 请配合[Qsign](https://gitee.com/touchscale/Qsign) 使用

#### 介绍
喵崽是一款很好用的原神QQ机器人，但是其使用的ICQQ常有问题，为了解决ICQQ的问题，需要自建API（[Qsign](https://gitee.com/touchscale/Qsign)）

但是，高版本的ICQQ使用的API经常崩溃，换成低版本以后又会登录不上，故写脚本自动重启之。
[Qsign](https://gitee.com/touchscale/Qsign)  中提供了windows的重启方式，但是没有其他操作系统的做法。
本脚本适用于ubuntu，其他linux系统或许也可用，自己试试吧。

截止本次修改readme.md，本脚本自测连续运行19天无任何问题，整个操作系统运行时内存占用约750MB。

已添加监测喵崽日志的功能，发现API异常后立即重启API。


#### 安装教程

1. 首先按照Qsign文档配置好Qsign签名API，确定版本，确保Qsign至少可以短时间内正常工作

2. 克隆仓库或下载 `monitor_app.sh` 文件，配置好变量

3. `chmod +x monitor_app.sh`  #赋予可执行权限

4. `su`  #切换到root用户

5. `./monitor_app.sh` #开始运行

6. 确认能正常运行后，在screen中运行脚本（推荐，可参考本文后续的`screen 简易用法`）, 或者用别的喜欢的方式把脚本挂在后台运行即可

#### 变量配置说明

1. 修改`monitor_app.sh`中的路径（`dir`）为你的Qsign所在的正确位置

2. 修改`monitor_app.sh`中的版本（`version`）为你需要的版本号

3. 修改`monitor_app.sh`中的路径（`dirMiao`）为你的Miao-Yunzai所在的正确位置

4. 检测间隔可以自行修改，默认15秒一次

#### screen 简易用法

1. 打开并进入新窗口 `screen -S <窗口名>`

2. 退出并关闭窗口 `Ctrl + D`

3. 将当前窗口挂在后台运行 `Ctrl + A + D`

4. 查看后台存在的窗口 `screen -ls`

5. 返回指定窗口 `screen -r <窗口名>`


#### 存在的问题

1.  本脚本会杀死Java进程，如果有别的服务以`Java`的形式运行，请注意。


#### 参与贡献

1.  你自己随便改就行

