#!/bin/bash
# 修改默认IP为 192.168.2.1 (根据需要修改)
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# =========================================================
# 补丁 1：强制修复 Redmi AX6 的 5G 无线与配置文件生成
# =========================================================
# 修正高通芯片组多物理无线接口识别，强制补齐 5G (phy1) 默认配置
mkdir -p package/base-files/files/etc/uci-defaults
cat << 'EOF' > package/base-files/files/etc/uci-defaults/99-fix-ax6-wifi
#!/bin/sh
if ! uci get wireless.radio1 >/dev/null 2>&1; then
    # 如果系统没有自动生成 radio1 (5G)，则强制通过底层检测重新生成
    rm -f /etc/config/wireless
    wifi detect > /etc/config/wireless
    /etc/init.d/network restart
fi
exit 0
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-fix-ax6-wifi
