#!/bin/bash

#################################################
# 描述: Debian/Ubuntu sing-box TProxy模式 停止脚本
# 版本: 1.1.0
# 作者: Youtube: 七尺宇
# 功能: 停止sing-box，并清理缓存以及防火墙
#################################################

# 检查是否以 root 权限运行
[ "$(id -u)" != "0" ] && { echo "错误: 此脚本需要 root 权限"; exit 1; }

# 停止 sing-box 服务
systemctl stop sing-box

# 清理 nftables 规则
nft flush ruleset

# 删除路由规则
ip rule del fwmark 1 table 100
ip route flush table 100

# 删除缓存文件
rm -f /etc/sing-box/cache.db

# 检查服务是否已停止
if ! systemctl is-active --quiet sing-box; then
    echo "sing-box 已停止"
else
    echo "停止 sing-box 失败，请检查日志"
    exit 1
fi

# 提示清理操作完成
echo "清理操作完成"
