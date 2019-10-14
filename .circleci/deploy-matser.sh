#!/usr/bin/env bash

user=root
host=ip
src=`pwd`"/"
des=/data/www/  # 网站目录？
now=`date +"%Y-%m-%d %H:%M:%S"`

#同步命令
# -v 同步时显示一些信息，让我们知道同步的过程 
# -z 传输时压缩
# -r 同步目录时要加上，类似cp时的-r选项
# -c 检查文件一致性 skip based on checksum, not mod-time & size
# --delete 删除DEST中SRC没有的文件
# --exclude 过滤指定文件，如--exclude “logs”会把文件名包含logs的文件或者目录过滤掉，不同步
rsync -vzrc --delete --exclude ".git" --exclude ".env" --exclude ".circleci" $src $user@$host:$des

ssh $user@$host "sudo chown -R www:www $des"

ssh $user@$host "cd $des && pwd && ls -al"

echo "$now update $host $des code"