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
* 该包带有自动部署脚本  

编译的qBittorrent 4.1.3（MT7620 uClibc库）有以下更新  
* qBittorrent-4.1.0 ==> qBittorrent-4.13
* qt-lib-5.5.1 ==> qt-lib-5.8.0  
* libtorrent-1.0.6 ==> libtorrent-1.1.10  
* boost-system-1.56 ==> boost-system-mt-1.68  
* 该包带有自动部署脚本  

已经修复4.1.0批量添加种子存在问题，修复死机问题。
目前已知的BUG：搭配libtoorrent-1.1.10 && boost-system-1.68会导致文件读写发生错误，目录相关操作失效。


另：目前以上版本无法以HTTPS协议的形式下载GEOIP的数据库（错误301），该协议实现要求SSL支持，需要QNetworkRequest封装SSL协议配置并传递给QNetworkAccessManager以实现下载，同时需要依赖openssl动态监测，可能需要重新编译现有的QT框架库，暂以通常HTTP协议下载解决。 

编译的qBittorrent 4.1.3（MT7621 uClibc库）由以下组件构成  
* qBittorrent-4.1.3
* libtorrent-1.0.11
* qt-lib-5.8.0（openssl-linked）
* boost-system-1.56（multi）
* openssl-1.0.2p  
* zlib-1.2.11  
* libiconv-1.15  

注：为了保证某些PT站点的种子正常下载（防止出现文件IO错误），换用了libtorrent1.0的分支，此外，已经发现使用libtorrent 1.0.11分支的qb在现有平台上的IO效能表现低于使用libtorrent 1.1.10分支，约会造成30%的性能损耗。另外，重新编译了QT框架库，内部集成了openssl，HTTPS下载功能已经恢复。  

编译的qBittorrent 4.1.5（MT7621 uClibc库）由以下组件构成  
* qBittorrent-4.1.5
* libtorrent-1.1.11
* qt-lib-5.8.0（openssl-runtime）
* boost-system-1.68（multi）
* openssl-1.0.2p  
* zlib-1.2.11  
* libiconv-1.15  

注：该版本添加了搜索插件，可在网页上进行种子的搜索。
