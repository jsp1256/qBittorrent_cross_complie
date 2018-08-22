# qBittorrent_cross_complie
这个是交叉编译的qBittorrent安装脚本，目标平台mipsel-openwrt-linux。压缩包内包含已编译的可执行的二进制文件   
编译的qBittorrent由以下组件构成  
* qBittorrent-3.3.15
* libtorrent-1.0.6
* qt-lib-4.8
* boost-system-1.56
* openssl-1.0.2g  
* zlib-1.2.11  
* libiconv-1.15

一键安装请执行：  
~~~
wget -c --no-check-certificate -O - https://raw.githubusercontent.com/jsp1256/qBittorrent_cross_complie/master/qBittorrent_install_oneclick.sh | /bin/sh 
~~~
