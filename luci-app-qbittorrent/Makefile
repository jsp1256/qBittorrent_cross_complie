include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-qbittorrent
PKG_VERSION=1.0
PKG_RELEASE:=1
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-qbittorrent
    SECTION:=luci
    CATEGORY:=LuCI
    SUBMENU:=3. Applications
    TITLE:=qbittorrent-nox for LuCI
    PKGARCH:=all
endef

define Package/luci-app-qbittorrent/description
    This package contains LuCI configuration pages for qbittorrent-nox.It has translation support for - 简体中文 (Simplified Chinese)
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-qbittorrent/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
    
	$(INSTALL_CONF) ./src/config/qbittorrent $(1)/etc/config/qbittorrent
	$(INSTALL_BIN) ./src/init.d/qbittorrent $(1)/etc/init.d/qbittorrent
	$(INSTALL_DATA) ./src/cbi/qbittorrent.lua $(1)/usr/lib/lua/luci/model/cbi/qbittorrent.lua
	$(INSTALL_DATA) ./src/controller/qbittorrent.lua $(1)/usr/lib/lua/luci/controller/qbittorrent.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) ./src/i18n/*.lmo $(1)/usr/lib/lua/luci/i18n/
endef

 $(eval $(call BuildPackage,luci-app-qbittorrent))
