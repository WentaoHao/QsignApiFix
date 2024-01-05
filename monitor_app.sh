#!/bin/bash

# 检查当前用户是否是root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Exiting."
    exit 1
else
    echo "Runing as root..."
fi

# 改成自己QSign的目录
dir="/home/haowentao/Miao-Yunzai/Qsign/unidbg-fetch-qsign"
# 改成自己的版本
version="8.9.93"
# 改成自己的喵崽所在的目录
dirMiao="/home/haowentao/Miao-Yunzai"

# 后续无需修改
bindir="$dir/bin/unidbg-fetch-qsign"
basePathDir="--basePath=$dir/txlib/$version"
output="output.log"
dirLogBase="$dirMiao/logs/command."

# 如果java已经在运行了，先将其杀死
if pgrep -f java; then
    echo "Java is running. Killing Java..."
    pid=$(pgrep -f "java")
    kill -9 $pid
fi

# 记录本次启动的时间点
firstTime=$(date +"%s")
# 启动API，将输出重定向到临时文件
bash $bindir $basePathDir >$output 2>&1 &
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
    
    # 获取当前日期，生成日志文件路径
    formatted_date=$(date "+%Y-%m-%d")
    dirLog="$dirLogBase$formatted_date.log"
    # 指定需要查询的错误信息
    old_string="签名api异常"
    new_string="API异常啦,哈哈"
    # 检查输出文件中是否包含关键字，或运行时长超过1小时
    if grep -q '警告' output.log || ((duration > 3600)) || grep -iq $old_string $dirLog ; then

        echo "Detected warning or overtime. Restarting the API..."

        # 获取java的进程ID并杀死它
        pid=$(pgrep -f "java")
        kill -9 $pid
        # 删除Qsign日志文件
        rm -f output.log
        # 修改喵崽日志文件，将本次API异常字样全部移除
        if [ -e "$dirLog" ]; then
        # 使用sed命令进行替换
            sed -i "s/$old_string/$new_string/g" $dirLog
            echo "Miao: Log file String replaced successfully."
        else
            echo "Miao: Log file not found."
        fi
        #记录本次启动的时间点
        firstTime=$(date +"%s")
        # 等待一段时间，然后重新启动API
        sleep 5
        bash $bindir $basePathDir >$output 2>&1 &
    else
        # 每15秒检测一次
        sleep 15
        if pgrep -f java; then
            echo "Java is running. No warning or error detected."
        else
            echo "Java is not running. Reruning API..."
            bash $bindir $basePathDir >$output 2>&1 &
        fi
    fi
done
