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

