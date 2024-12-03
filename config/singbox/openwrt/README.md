**声明**：如果遇到兼容崩溃500报错等奇怪问题，请尝试更换singbox内核版本，个人建议Linux跑sing-box，最稳定！
**注意**：如果你的后端没有科学环境，规则地址前记得添加镜像否则无法拉取。  
例如：  
```
https://ghp.ci/https://raw.githubusercontent.com/qichiyuhub/rule/refs/heads/master/config/singbox/config_tproxy.json
```

openwrt运行singbox需求版本和依赖：  

固件版本:  

- OpenWrt >= 23.05  

- firewall4

必要依赖：  

- ca-bundle  

- curl  

- yq  

- firewall4  

- ip-full  

- kmod-inet-diag  

- kmod-nft-tproxy  

- kmod-tun