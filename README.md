# jzg_monitor

Step1 zabbix agent安装。zabbix实现的基本功能，就是可以在远程帮user执行一些命令，把命令的结果存入zabbix后台&展示。

Step2 本地命令开发，代码中脚本python&shell都是为了本地获取数据。命令返回的数据格式要符合zabbix的约定<xml模板描述>。

Step3 本地命令ok之后，配置zabbix agent的conf文件。增加命令项并重启。然后从远程zabbix get可以验证是否ok。

Step4 zabbix管理页面，导入模板&立即刷新，即可看到数据展示到界面。

```
zabbix agent安装：
    在Ubuntu 18.04、CentOS 7上安装和配置Zabbix agent 4.0的方法
    参考 https://ywnz.com/linuxyffq/4186.html
    wget https://repo.zabbix.com/zabbix/4.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.4-1+bionic_all.deb
    dpkg -i zabbix-release_4.4*
    apt update
    apt install zabbix-agent zabbix-sender
    apt install zabbix-get
    systemctl status zabbix-agent
    ufw allow 10050/tcp
    ss -tunelp | grep 10050
    参照 https://blog.csdn.net/qq_33633013/article/details/83503804
    apt install python-simplejson -y
    
zabbix agent重启：
    systemctl restart zabbix-agent
```
