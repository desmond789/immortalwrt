#!/bin/bash
# Un-comment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# 注入包含各种流行插件的第三方大仓库源（给编译做双重保险）
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default

# 配合你的特殊克隆脚本，提升克隆成功率
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999
