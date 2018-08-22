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
##安装必要的软件包
install_soft
mkdir tmp
cd tmp
wget -c https://github.com/jsp1256/qBittorrent_cross_complie/raw/master/qb_release.tar.gz
wget -c -O - https://raw.githubusercontent.com/jsp1256/qBittorrent_cross_complie/master/qBittorrent_install.sh | /bin/sh
cd ..
rm -rf tmp