#!/bin/sh
##qBittorrent v4.1.3部署安装脚本
##qBittorrent_install_4.1.3.sh
##version: 1.0

##### 配置文件 #####
USB_PATH=""
SOFT_PATH=""
GZ_FILENEME="qb-release-4.1.3.tar.gz"

##### 导入公共函数库 #####
source ./lib.sh

##### 主函数入口点 #####
#配置外置存储目录
config_USB_PATH
#解压程序文件
extract_data $SOFT_PATH $GZ_FILENEME
#配置qBittorrent
echo "正在配置qBittorrent"
config_qbittorrent_V4 $USB_PATH $SOFT_PATH
#添加开机自启
config_startup $USB_PATH $SOFT_PATH
#配置环境变量
config_env $SOFT_PATH
#运行qBittorrent
echo "正在启动qBittorrent-nox"
start_qbittorrent $SOFT_PATH
