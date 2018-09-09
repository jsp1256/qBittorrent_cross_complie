#!/bin/sh
##qBittorrent v4.1.2 on mt7621-musl部署安装脚本
##qBittorrent_install_4.1.2-mt7621-musl
##version: 1.0

##### 配置文件 #####
USB_PATH=""
SOFT_PATH=""

##### 前置函数起始点 #####
##### 配置外接存储路径 #####
config_USB_PATH(){
    if [ -z "$USB_PATH" ]; then
        #获取USB外置存储挂载根目录，多次重复匹配，防止重复
        USB_PATH=`df -h | grep -no "/mnt/[0-9_a-zA-Z]*" | grep -no "/mnt/[0-9_a-zA-Z]*" | grep -o "1:/mnt/[0-9_a-zA-Z]*" | grep -o "/mnt/[0-9_a-zA-Z]*"`
        USB_SOFTPATH="$USB_PATH/opt"
        if [ -z "$USB_PATH" ]; then 
	        echo "未探测到已挂载的USB分区"
	        exit 0
        fi
    fi
    SOFT_PATH=$USB_PATH/qbittorrent
}

##### 配置开机启动 #####
##参数: $1:USB挂载点 
config_startup(){
    cat>/etc/init.d/qBittorrent<<EOF
#!/bin/sh /etc/rc.common
START=99

boot(){
    start
}
start() {
    cd $1/qbittorrent/bin
    export HOME=/root
    export LD_LIBRARY_PATH=$1/qbittorrent/lib
    ./qbittorrent-nox --profile=/root/Settings/ &
}
EOF
    chmod a+x /etc/init.d/qBittorrent
    chmod a+x $1/qbittorrent/bin/qbittorrent-nox
    /etc/init.d/qBittorrent enable
}

##### 配置qBittorrent配置文件 #####
##参数: $1:USB挂载点 $2:程序安装目录
config_qbittorrent(){
mkdir -p $1/Downloads
mkdir -p $2/share/Settings/qBittorrent/config
    cat>$2/share/Settings/qBittorrent/config/qBittorrent.conf<<EOF
[AutoRun]
enabled=false
program=

[LegalNotice]
Accepted=true

[Network]
Cookies=@Invalid()

[Preferences]
Bittorrent\AddTrackers=false
Bittorrent\MaxRatioAction=0
Bittorrent\PeX=true
Connection\GlobalDLLimitAlt=10
Connection\GlobalUPLimitAlt=10
Downloads\PreAllocation=false
Downloads\SavePath=$1/Downloads/
Downloads\ScanDirsV2=@Variant(\0\0\0\x1c\0\0\0\0)
Downloads\TempPath=$1/Downloads/temp/
Downloads\TempPathEnabled=true
DynDNS\DomainName=changeme.dyndns.org
DynDNS\Enabled=false
DynDNS\Password=
DynDNS\Service=0
DynDNS\Username=
General\Locale=zh
General\UseRandomPort=false
MailNotification\email=
MailNotification\enabled=false
MailNotification\password=
MailNotification\req_auth=false
MailNotification\req_ssl=false
MailNotification\smtp_server=smtp.changeme.com
MailNotification\username=
WebUI\HTTPS\Enabled=false
WebUI\LocalHostAuth=true
WebUI\Port=8080
WebUI\ServerDomains=*
WebUI\UseUPnP=true
WebUI\Username=admin
EOF
    rm -rf /root/Settings/qBittorrent
    mkdir -p /root/Settings
    ln -s $2/share/Settings/qBittorrent/ /root/Settings/qBittorrent
    if [ $? -ne 0 ]; then
        echo "无法创建符号链接，请确保以root身份执行程序！"
        exit 0;
    fi
}

##### 解压程序文件 #####
##参数: $1:程序安装目录
extract_data(){
    if [ -f "qbittorrent-release-4.1.2-mt7621-musl.tar.gz" ]; then
        echo 解压qbittorrent-release-4.1.2-mt7621-musl.tar.gz...
        tar xzf qbittorrent-release-4.1.2-mt7621-musl.tar.gz
        if [ $? -ne 0 ]; then
           echo "解压程序文件失败，请确认是否有足够的空间"
          exit 0;
        fi
        rm -rf $1
        mv install/ $1
    else
        echo 找不到qbittorrent-release-4.1.2-mt7621-musl.tar.gz，请确认其是否放置相同目录下！
        exit 0
    fi
}

##### 配置环境变量 #####
##参数: $1:程序安装目录
config_env(){
    echo "export PATH=$PATH:$1/bin" >> /etc/profile
    echo "export LD_LIBRARY_PATH=$1/lib" >> /etc/profile
    source /etc/profile
}

##### 配置环境变量 #####
start_qbittorrent(){
    qbittorrent-nox > /dev/null 2>&1 &
    if [ $? -ne 0 ]; then
        echo "qBittorrent-nox启动失败，请手动启动"
        exit 0;
    else
        echo "已经成功后台启动qBittorrent-nox"
        LAN_IP=$(ubus call network.interface.lan status | grep \"address\" | grep -oE '[0-9]{0,3}\.[0-9]{0,3}\.[0-9]{0,3}\.[0-9]{0,3}')
        if [ -z "$LAN_IP" ]; then
            echo "网页访问请输入http://路由器IP地址:8080"
        else
            echo "网页访问请输入http://$LAN_IP:8080"
        fi
        echo "默认用户名：admin"
        echo "默认密码：adminadmin"
    fi
}
##### 前置函数终止点 #####

##### 主函数入口点 #####
#配置外置存储目录
config_USB_PATH
#解压程序文件
extract_data $SOFT_PATH
#配置qBittorrent
echo "正在配置qBittorrent"
config_qbittorrent $SOFT_PATH
#添加开机自启
config_startup $USB_PATH
#配置环境变量
config_env $SOFT_PATH
#运行qBittorrent
echo "正在启动qBittorrent-nox"
start_qbittorrent
