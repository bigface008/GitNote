# FANQIANG 大作战

## SSR

1. 下载一键搭建ssr脚本
   ```shell
   git clone -b master https://github.com/flyzy2005/ss-fly
   ```

2. 运行搭建ssr脚本代码
   ```shell
   ss-fly/ss-fly.sh -ssr
   ```

3. 输入对应的参数

   执行完上述的脚本代码后，会进入到输入参数的界面，包括服务器端口，密码，加密方式，协议，混淆。可以直接输入回车选择默认值，也可以输入相应的值选择对应的选项：

   全部选择结束后，会看到如下界面，就说明搭建ssr成功了：
   ```shell
   Congratulations, ShadowsocksR server install completed!
   Your Server IP        :你的服务器ip
   Your Server Port      :你的端口
   Your Password         :你的密码
   Your Protocol         :你的协议
   Your obfs             :你的混淆
   Your Encryption Method:your_encryption_method

   Welcome to visit:https://shadowsocks.be/9.html
   Enjoy it!
   ```

4. 相关操作ssr命令

   - 启动：`/etc/init.d/shadowsocks start`
   - 停止：`/etc/init.d/shadowsocks stop`
   - 重启：`/etc/init.d/shadowsocks restart`
   - 状态：`/etc/init.d/shadowsocks status`

   - 配置文件路径：`/etc/shadowsocks.json`
   - 日志文件路径：`/var/log/shadowsocks.log`
   - 代码安装目录：`/usr/local/shadowsocks`

5. 卸载ssr服务
   ```shell
   ./shadowsocksR.sh uninstall
   ```

## SS

本脚本适用环境：
系统支持：CentOS/Debian/Ubuntu 内存要求：≥128M
日期：2017 年 07 月 28 日

关于本脚本：
一键安装 libev 版的 Shadowsocks 最新版本。该版本的特点是内存占用小（600k左右），低 CPU 消耗，甚至可以安装在基于 OpenWRT 的路由器上。

默认配置：
服务器端口：自己设定（如不设定，默认为 8989）
密码：自己设定（如不设定，默认为teddysun.com）
加密方式：自己设定（如不设定，默认为 aes-256-gcm）

客户端下载：
[https://github.com/shadowsocks/shadowsocks-windows/releases](https://github.com/shadowsocks/shadowsocks-windows/releases)

使用方法：
使用root用户登录，运行以下命令：

## CentOS

```
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-libev.sh
chmod +x shadowsocks-libev.sh
./shadowsocks-libev.sh 2>&1 | tee shadowsocks-libev.log
```

### Debian && Ubuntu

```
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-libev-debian.sh
chmod +x shadowsocks-libev-debian.sh
./shadowsocks-libev-debian.sh 2>&1 | tee shadowsocks-libev-debian.log
```

安装完成后，脚本提示如下：

```
Congratulations, shadowsocks-libev install completed!
Your Server IP:your_server_ip
Your Server Port:your_server_port
Your Password:your_password
Your Local IP:127.0.0.1
Your Local Port:1080
Your Encryption Method:aes-256-cfb

Welcome to visit:http://teddysun.com/357.html
Enjoy it!
```

卸载方法：
使用 root 用户登录，运行以下命令： ``./shadowsocks-libev.sh uninstall``

使用命令：
启动：`/etc/init.d/shadowsocks start`
停止：`/etc/init.d/shadowsocks stop`
重启：`/etc/init.d/shadowsocks restart`
查看状态：`/etc/init.d/shadowsocks status`

参考链接：
[https://github.com/madeye/shadowsocks-libev](https://github.com/madeye/shadowsocks-libev)
[https://shadowsocks.be/4.html](https://shadowsocks.be/4.html)