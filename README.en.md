# Linux Script to Solve QSignApi Auto-Crash Issue for Miao-YunzaiBot

### Please use with [Qsign](https://gitee.com/touchscale/Qsign)

#### Introduction
Miao-Yunzai is a handy Genshin Impact QQ robot, but it often encounters issues with the ICQQ it uses. To address the problems with ICQQ, it's necessary to set up a self-built API ([Qsign](https://gitee.com/touchscale/Qsign)).

However, the API used by higher versions of ICQQ tends to crash frequently, and switching to lower versions may result in login failures. Therefore, this script is written to automatically restart it.
[Here](https://gitee.com/touchscale/Qsign/issues/I8GLZN) provides a restart method for Windows, but there is no method for other operating systems. This script is suitable for Ubuntu, and perhaps other Linux systems may also work. Give it a try.

As of the latest update to the README.en.md, this script has been self-tested and running continuously for 19 days without any issues, with a memory footprint of approximately 750MB.


```
-------状态-------
运行时间：19天5小时53分钟
内存使用：177.75MB
当前版本：v3.1.3
```

#### Installation Tutorial

1. First, configure the Qsign signature API and determine the version.

2. Clone the repository or download the `monitor_app.sh` file and configure the variables.

3. `chmod +x monitor_app.sh` #grant executable permissions

4. `su` #switch to the root user

5. `./monitor_app.sh` #start running

6. After confirming that it runs normally, run the script in `screen` (recommended) or run the script in the background in any other preferred way.

#### Variable Configuration Explanation

1. Modify the path (`dir`) in `monitor_app.sh` to the correct location of your Qsign.

2. Modify the version (`version`) in `monitor_app.sh` to the version number you need.

3. The detection interval can be modified as needed, defaulting to once every 10 seconds.

#### Existing Issues

1. This script will kill the Java process. If other services are running in Java form, please be cautious.


#### Contribution

1. Feel free to make any changes on your own.