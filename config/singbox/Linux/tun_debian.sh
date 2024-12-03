#!/bin/bash

#################################################
# 描述: Debian/Ubuntu/Armbian sing-box TUN模式 配置脚本
# 版本: 1.1.0
# 作者: Youtube: 七尺宇
# 功能: 更新替换配置文件
#################################################

# 配置参数
BACKEND_URL="http://10.10.10.9:5000"                       # 后端服务器地址
SUBSCRIPTION_URL=""   # 订阅地址 Clash.Meta(mihomo)
TEMPLATE_URL="https://raw.githubusercontent.com/qichiyuhub/rule/refs/heads/master/config/singbox/config_tun.json"  # 配置模板 URL
TUN_PORT=7895                                                 # TUN 端口

# 检查是否以 root 权限运行并且 sing-box 是否已安装
[ "$(id -u)" != "0" ] && { echo "错误: 此脚本需要 root 权限"; exit 1; }
command -v sing-box &> /dev/null || { echo "错误: sing-box 未安装"; exit 1; }

# 停止 sing-box 服务
systemctl stop sing-box

# 构建完整的配置文件 URL
FULL_URL="${BACKEND_URL}/config/${SUBSCRIPTION_URL}&file=${TEMPLATE_URL}"

echo -e "\033[36m==============================================================================\033[0m"
echo -e "\033[32m生成完整订阅链接: \033[0m\033[31m$FULL_URL\033[0m"
echo -e "\033[36m==============================================================================\033[0m"

# 备份当前配置
[ -f "/etc/sing-box/config.json" ] && cp /etc/sing-box/config.json /etc/sing-box/config.json.backup

# 下载并验证配置文件
if curl -L --connect-timeout 10 --max-time 30 "$FULL_URL" -o /etc/sing-box/config.json; then
    echo "配置文件下载成功"
    if ! sing-box check -c /etc/sing-box/config.json; then
        echo "配置文件验证失败，正在还原备份"
        [ -f "/etc/sing-box/config.json.backup" ] && cp /etc/sing-box/config.json.backup /etc/sing-box/config.json
        exit 1
    fi
else
    echo "配置文件下载失败"
    exit 1
fi

# 设置正确的权限
chmod 640 /etc/sing-box/config.json

# 启动 sing-box 服务
systemctl start sing-box

# 检查服务是否启动成功
if systemctl is-active --quiet sing-box; then
    echo "sing-box 启动成功，运行模式: TUN"
else
    echo "服务启动失败，请检查日志"
    exit 1
fi

# 常用命令
echo -e "\033[36m================================================\033[0m"
echo "* 检查singbox: systemctl status sing-box.service"
echo "* 查看实时日志: journalctl -u sing-box --output cat -f"
echo "* 检查配置文件: sing-box check -c /etc/sing-box/config.json"
echo "* 运行singbox: sing-box run -c /etc/sing-box/config.json"
echo "* 查看nf防火墙: nft list ruleset"
echo -e "\033[36m================================================\033[0m"
