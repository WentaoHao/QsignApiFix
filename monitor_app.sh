#!/bin/bash

dir="/home/haowentao/Miao-Yunzai/Qsign/unidbg-fetch-qsign"
bindir="$dir/bin/unidbg-fetch-qsign"
version="8.9.93"
basePathDir="--basePath=$dir/txlib/$version"
output="output.log"
superdo="sudo"

app="sudo bash $bindir $basePathDir $output"
echo "$app"
# 提权为root
sudo -v
# 启动API，将输出重定向到临时文件
# bash $dir/bin/unidbg-fetch-qsign --basePath=txlib/8.9.93  > output.log 2>&1
sudo bash $bindir $basePathDir > $output 2>&1
while true; do
    
    # 检查输出文件中是否包含关键字
    if grep -qE 'WARNING|ERROR|警告' output.log; then
        echo "Detected warning or error. Restarting the app..."
        
        # 获取java的进程ID并杀死它
        pid=$(pgrep -f "java")
        kill $pid
        # 删除日志文件
        rm -f output.log
        # 等待一段时间，然后重新启动API
        sleep 5
        bash $app
        
    else
        echo "No warning or error detected."
        # 每10秒检测一次
        sleep 10
        break
    fi
done