**注意**：如果你的后端没有科学环境，规则地址前记得添加镜像否则无法拉取。  
例如：  
```
https://ghp.ci/https://raw.githubusercontent.com/qichiyuhub/rule/refs/heads/master/config/singbox/config_tproxy.json
```
运行前，确保系统没有科学，后端、订阅、配置文件正常！  

**自动更新订阅，重启系统自动重启singbox，执行如下命令即可！**

定时自动更新订阅（每天 6 点执行 `/root/debian_tproxy.sh`)  

```
echo "0 6 * * * /root/debian_tproxy.sh" | crontab -  
```


重启后自动更新订阅并启动（系统启动时执行 `/root/debian_tproxy.sh`)  

```
echo "@reboot /root/debian_tproxy.sh" | crontab -
```

检查定时任务列表

```
crontab -l
```

清除定时任务

```
crontab -r
```

以上演示为Tproxy模式，TUN模式自行更换脚本名字即可！