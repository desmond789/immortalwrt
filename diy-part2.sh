#!/bin/bash
# 修改默认IP为 192.168.2.1 (根据需要修改)
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# =========================================================
# 补丁 1：强制修复 Redmi AX6 的 5G 无线与配置文件生成
# =========================================================
# 很多高通 Combined 驱动无法自动生成第二个物理无线接口，强制注入
if [ -f "package/kernel/mac80211/files/lib/wifi/mac80211.sh" ]; then
    sed -i 's/hwmode=11g/hwmode=11a/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
fi

# =========================================================
# 补丁 2：强制开启简体中文支持（确保不被 defconfig 删掉）
# =========================================================
echo "CONFIG_LUCI_LANG_zh_Hans=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-base-zh-cn=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-opkg-zh-cn=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-firewall-zh-cn=y" >> .config

# =========================================================
# 补丁 3：为你想要但经常丢失的核心应用做“保活强制注入”
# =========================================================
# 这样即便上面的 git clone 漏了某些依赖，也能保证基础 LuCI 和对应插件被强行编译
echo "CONFIG_PACKAGE_luci=y" >> .config
echo "CONFIG_PACKAGE_luci-app-homeproxy=y" >> .config
echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config
echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config
