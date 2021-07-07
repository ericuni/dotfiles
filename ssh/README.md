[SSH 的配置与管理](https://mac.bestswifter.com/mac-gong-zuo-liu/ssh-de-pei-zhi-yu-guan-li.html)

- ForwardAgent:假设我通过 SSH 连接上了服务器 A(通常在公司内部有跳板机时格外有用),又从服务器 A 连接到服务器 B,如果将 ForwardAgent 配置为 YES,在两台服务器之间传输数据就不会经过本机.
- ServerAliveInterval 和 ServerAliveCountMax:表示客户端定期向服务端发送心跳包,使得服务端不会断开 SSH 的连接.这里表示 10 秒发一次,发 1W 次.
- ControlMaster, ControlPath, ControlPersist: 每次建立远程连接,在 ~/.ssh 目录下都会建立一个 socket 文件.这三个配置连用,表示缓存 socket 文件,并保留 4 小时,这样可以加快下次连接的速度.

给机器起一个alias, 例如config 里面的testhost, 配置了免密登录之后, 使用`ssh testhost` 就可以快速登录系统, shell 还支持自动补全.

