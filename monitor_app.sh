#!/bin/bash

# 检查当前用户是否是root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Exiting."
    exit 1
fi

#改成自己的目录
dir="/home/haowentao/Miao-Yunzai/Qsign/unidbg-fetch-qsign"
#改成自己的版本
version="8.9.93"
bindir="$dir/bin/unidbg-fetch-qsign"
basePathDir="--basePath=$dir/txlib/$version"
output="output.log"


# app="sudo bash $bindir $basePathDir $output"
# echo "$app"
# 提权为root
sudo -v
# 启动API，将输出重定向到临时文件
# bash $dir/bin/unidbg-fetch-qsign --basePath=txlib/8.9.93  > output.log 2>&1
sudo bash $bindir $basePathDir > $output 2>&1
while true; do
    
    # 检查输出文件中是否包含关键字
    if grep -qE 'WARNING|ERROR|警告|error' output.log; then
        echo "Detected warning or error. Restarting the app..."
        
        # 获取java的进程ID并杀死它
        pid=$(pgrep -f "java")
        kill -9 $pid
        # 删除日志文件
        rm -f output.log
        # 等待一段时间，然后重新启动API
        sleep 5
        sudo bash $bindir $basePathDir > $output 2>&1
        
    else
        echo "No warning or error detected."
        # 每10秒检测一次
        sleep 10
        break
    fi
done