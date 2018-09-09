# qBittorrent_cross_complie
这个是交叉编译的qBittorrent安装脚本，目标平台mipsel-openwrt-linux。压缩包内包含已编译的可执行的二进制文件   
编译的qBittorrent 3.3.15（MT7620 uClibc库）由以下组件构成  
* qBittorrent-3.3.15
* libtorrent-1.0.6
* qt-lib-4.8
* boost-system-1.56
* openssl-1.0.2g  
* zlib-1.2.11  
* libiconv-1.15  

编译的qBittorrent 4.4.10（MT7620 uClibc库）有以下更新  
* qBittorrent-3.3.15 ==> qBittorrent-4.4.10
* qt-lib-4.8 ==> qt-lib-5.5.1  

编译的qBittorrent 4.4.12（MT7621 musl库）有以下更新  
* qBittorrent-3.3.15 ==> qBittorrent-4.4.12
* qt-lib-4.8 ==> qt-lib-5.8.0  
* openssl-1.0.2g ==> openssl-1.0.2p
* qt-lib-4.8 ==> qt-lib-5.8.0  
* libtorrent-1.0.6 ==> libtorrent-1.1.9  
* boost-system-1.56 ==> boost-system-mt-1.68  
* + boost-chrono-mt-1.68 
* + boost-random-mt-1.68 

一键安装请执行：  
~~~
wget -c --no-check-certificate -O - https://raw.githubusercontent.com/jsp1256/qBittorrent_cross_complie/master/qBittorrent_install_oneclick.sh | /bin/sh 
~~~
  
计划中的版本：  
qBittorrent-4.4.12  
├── libtorrent-1.1.19  
│   ├── boost-system-1.68  
│   ├── boost-chrono-1.68  
│   ├── boost-random-1.68  
│   ├── openssl-1.0.2g   
│   ├── zlib-1.2.11  
│   └── libiconv-1.15  
└── qt-lib-5.11  
因为对现有架构发生很大的改动（核心库发生版本迭代），编译有难度。现在没有精力于是不得不暂且搁置  
另：目前版本无法下载GEOIP的数据库，问题有待排查（应该出在QT库接口问题，可能需要重写函数实现）  
