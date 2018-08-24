#!/bin/sh
##qBittorrent一键部署安装脚本
##qBittorrent_install_oneclick.sh
##version: 1.0
install_list="wget ca-certificates"

##### 软件包状态检测 #####
install_soft(){
    echo "正在更新软件源"
    opkg update >/dev/null  2>&1 
    for data in $install_list ; do
        if [[ `opkg list-installed | grep $data | wc -l` -ne 0 ]];then
            echo "$data 已安装"
        else
            echo "$data 正在安装..."
            opkg install $data > /dev/null 2>&1
        fi
    done
    #wget: 强行替换内置版本为标准版本
    ln -sf /usr/bin/wget /bin/wget
}

echo  "请选择要安装的qBittorrent版本,输入数字[1-2]"
echo  "1. qBittorrent-4.1.0 (with Qt5)"
echo  "2.qBittorrent-3.3.15 (with Qt4)"
read flag
##安装必要的软件包
install_soft
mkdir tmp
cd tmp
if [ $flag = "1" ]; then
    wget -c https://github.com/jsp1256/qBittorrent_cross_complie/raw/master/qb_release-4.1.0.tar.gz
    wget -c -O - https://raw.githubusercontent.com/jsp1256/qBittorrent_cross_complie/master/qBittorrent_install_4.1.0.sh | /bin/sh
else if [ $flag = "2" ] then
    wget -c https://github.com/jsp1256/qBittorrent_cross_complie/raw/master/qb_release.tar.gz
    wget -c -O - https://raw.githubusercontent.com/jsp1256/qBittorrent_cross_complie/master/qBittorrent_install.sh | /bin/sh
else
    echo "退出安装"
fi
cd ..
rm -rf tmp
