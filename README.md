# qBittorrent_cross_complie
这个是交叉编译的qBittorrent安装脚本，目标平台mipsel-openwrt-linux。压缩包内包含已编译的可执行的二进制文件  
共有BUG：GEOIP数据库下载失败，导致没有对应的国家解析，该BUG已经在最新编译的4.1.3版本中修复。

编译的qBittorrent 3.3.15（MT7620 uClibc库）由以下组件构成  
* qBittorrent-3.3.15
* libtorrent-1.0.6
* qt-lib-4.8
* boost-system-1.56
* openssl-1.0.2g  
* zlib-1.2.11  
* libiconv-1.15  

编译的qBittorrent 4.4.13（MT7620 uClibc库）有以下更新  
* qBittorrent-4.4.10 ==> qBittorrent-4.4.13
* qt-lib-5.5.1 ==> qt-lib-5.8.0  
* libtorrent-1.0.6 ==> libtorrent-1.0.11  
* boost-system-1.56 ==> boost-system-mt-1.60  
已经修复4.1.0批量添加种子存在问题。
目前已知的BUG：搭配libtoorrent-1.1.10 && boost-system-1.68会导致文件读写发生错误，目录相关操作失效。

编译的qBittorrent 4.4.12（MT7621 musl库）有以下更新  
* qBittorrent-3.3.15 ==> qBittorrent-4.4.12
* qt-lib-4.8 ==> qt-lib-5.8.0  
* openssl-1.0.2g ==> openssl-1.0.2p
* qt-lib-4.8 ==> qt-lib-5.8.0  
* libtorrent-1.0.6 ==> libtorrent-1.1.9  
* boost-system-1.56 ==> boost-system-mt-1.68  
* ++ boost-chrono-mt-1.68 
* ++ boost-random-mt-1.68  
目前已知的BUG:4.1.2监听地址有错误，需要手动修改配置文件，具体可以参考https://github.com/qbittorrent/qBittorrent/issues/9333，  
另外，种子最大连接数超过10个会发生崩溃。

一键安装请执行：  
~~~
wget -c --no-check-certificate -O - https://raw.githubusercontent.com/jsp1256/qBittorrent_cross_complie/master/qBittorrent_install_oneclick.sh | /bin/sh 
~~~
  
另：目前版本无法以HTTPS协议的形式下载GEOIP的数据库（错误301），该协议实现要求SSL支持，需要QNetworkRequest封装SSL协议配置并传递给QNetworkAccessManager以实现下载，同时需要依赖openssl动态监测，可能需要重新编译现有的QT框架库，暂以通常HTTP协议下载解决。  
