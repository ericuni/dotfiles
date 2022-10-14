# mac
## brew
[cast formula](https://formulae.brew.sh/cask/)

- yinxiangbiji: 印象笔记
- adrive: 阿里网盘
- maczip: eZip
- maccy: clipboard manager

## App Store
- Get Plain Text
- Hidden Bar

## dmg
- Downie
- 壁纸: pap.er
- docker

## tips
[Enable Touch ID for sudo](https://sixcolors.com/post/2020/11/quick-tip-enable-touch-id-for-sudo/)

```bash
sudo vi /etc/pam.d/sudo

```
在开头的注释后第一行增加下面内容
```plain
auth sufficient pam_tid.so
```
注: 加到最后一行不行

mysql
```bash
brew services start/stop/info/run mysql
```

