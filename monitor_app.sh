#!/bin/bash

# 检查当前用户是否是root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Exiting."
    exit 1
else
    echo "Runing as root..."
        
fi

#改成自己QSign的目录
dir="/home/haowentao/Miao-Yunzai/Qsign/unidbg-fetch-qsign"
#改成自己的版本
version="8.9.93"
bindir="$dir/bin/unidbg-fetch-qsign"
basePathDir="--basePath=$dir/txlib/$version"
output="output.log"

# 如果java已经在运行了，先将其杀死
if pgrep -f java ; then
    echo "Java is running. Killing Java..."
    pid=$(pgrep -f "java")
    kill -9 $pid
fi

# 记录本次启动的时间点
firstTime=$(date +"%s")
# 启动API，将输出重定向到临时文件
bash $bindir $basePathDir > $output 2>&1 &
while true; do
    # 计算本次运行的时长
    secondTime=$(date +"%s")
    duration=$((secondTime - firstTime))

    # TODO:
    # 计算两次重启的时间差值，小于10分钟则重启喵崽
    # 使用 pgrep -f 找到所有匹配的 PID，并使用 pkill 杀死它们

    # pids=$(pgrep -f "your_process_name_or_pattern")

    # if [ -n "$pids" ]; then
    #     echo "Killing processes with PIDs: $pids"
    #     pkill -P "$pids"
    # 
    # fi


    # 检查输出文件中是否包含关键字，或运行时长超过1小时
    if grep -q '警告' output.log || ((duration > 3600)) ; then
        
        echo "Detected warning or overtime. Restarting the API..."
        
        
        # 获取java的进程ID并杀死它
        pid=$(pgrep -f "java")
        # echo "pid: $pid"
        kill -9 $pid
        # 删除日志文件
        rm -f output.log
        #记录本次启动的时间点
        firstTime=$(date +"%s")
        # 等待一段时间，然后重新启动API
        sleep 5
        bash $bindir $basePathDir > $output 2>&1 &
        
    else
        # 每10秒检测一次
        sleep 10
        if pgrep -f java ; then
            echo "Java is running. No warning or error detected."
        else
            echo "Java is not running. Reruning API..."
            bash $bindir $basePathDir > $output 2>&1 &
        fi  
    fi
done