- [FZF window not appearing until keypress in Neovim in Docker when using shortcut](
  https://github.com/junegunn/fzf.vim/issues/497)
- [docker change Ctrl+p to something else?](
  https://stackoverflow.com/questions/20828657/docker-change-ctrlp-to-something-else)

sysstat: for sar

```bash
nohup docker build --tag ubuntu:latest.`date +%Y%m%d%H%M%S` ./ &
```

install other staff with [script](https://github.com/ericuni/dotfiles/blob/master/env/linux.sh)

[ubuntu releases](https://wiki.ubuntu.com/Releases)
```
// 查看Ubuntu 版本
lsb_release -a
```

[探讨Docker容器中修改系统变量的方法](
https://tonybai.com/2014/10/14/discussion-on-the-approach-to-modify-system-variables-in-docker/)

使用–privileged选项, 容器获得了额外的特权,并且可以对系统变量的值进行修改了.不过这样的修改是不能保存在容器里的, 我们stop
容器,再重启该容器就能看出来.
这样一来,我们能做的只有把产品启动与系统变量值修改放在一个脚本中了,并将该脚本作为docker 容器的cmd命令来执行.

# docker 版本导致的错误
18.06.1-ce 版本的docker 在使用 ubuntu:21.10 时, 会报下面的错误
```plain
W: GPG error: http://security.ubuntu.com/ubuntu impish-security InRelease: gpgv, gpgv2 or gpgv1 required for verification, but neither seems installed
E: The repository 'http://security.ubuntu.com/ubuntu impish-security InRelease' is not signed.
W: GPG error: http://archive.ubuntu.com/ubuntu impish InRelease: gpgv, gpgv2 or gpgv1 required for verification, but neither seems installed
E: The repository 'http://archive.ubuntu.com/ubuntu impish InRelease' is not signed.
W: GPG error: http://archive.ubuntu.com/ubuntu impish-updates InRelease: gpgv, gpgv2 or gpgv1 required for verification, but neither seems installed
E: The repository 'http://archive.ubuntu.com/ubuntu impish-updates InRelease' is not signed.
W: GPG error: http://archive.ubuntu.com/ubuntu impish-backports InRelease: gpgv, gpgv2 or gpgv1 required for verification, but neither seems installed
E: The repository 'http://archive.ubuntu.com/ubuntu impish-backports InRelease' is not signed.
```

apt update 报下面的错误
```plain
Reading package lists... Done
E: Problem executing scripts APT::Update::Post-Invoke 'rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true'
E: Sub-process returned an error code
```

解决方法: 升级docker 的版本
[Install static binaries](https://docs.docker.com/engine/install/binaries/#install-daemon-and-client-binaries-on-linux)

```bash
wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.18.tgz
sudo service docker status
sudo systemctl status containerd.service
sudo cp docker/* /usr/bin/
sudo service docker start
```

cp 那一步可能会提示一些busy 的错误, 例如
```plain
cp: cannot create regular file '/usr/bin/containerd-shim-runc-v2': Text file busy
```
可以忽略

