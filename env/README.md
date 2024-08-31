# mac
## brew
[cast formula](https://formulae.brew.sh/cask/)

- yinxiangbiji: 印象笔记
- adrive: 阿里网盘
- maczip: eZip
- paper: 壁纸pap.er
- xld: Lossless audio decoder, convert FLAC to Apple Lossless Music
- novabench: Free benchmark software to test your computer's performance
- jq: pretty json
- bat: cat with syntax highlighting and Git integration
- btm: bottom, Yet another cross-platform graphical process/system monitor compared with top
- joshuto: ranger-like terminal file manager in rust
- procs: A modern replacement for ps written in rust

brew service

- `brew services run mysql`: Run the service formula without registering to launch at login (or boot)
- `brew services start mysql`: Start the service formula immediately and register it to launch at login

### homebrew terminology
[What does brew tap mean?](https://stackoverflow.com/questions/34408147/what-does-brew-tap-mean)

- package ≡ formula ≡ ruby file: this typically deals with command line (CLI) software
- bottle: binary program already built for some OS
- casks: GUI program or font; this is an extension of homebrew that allows us to install MacOS native applications like:
  Google Chrome, iterm2, Visual Studio Code etc. As well as install fonts: Roboto Mono("font-roboto" font-roboto-mono),
  Latin Modern(font-latin-modern), etc.
- taps: [Github|Gitlab|...] repositories containing additional packages that are not standard, i.e not incorporated into
  the official homebrew repository.

Packages are installed into `/usr/local/Cellar/<package>` with symlinks into `/usr/local/bin` and `/usr/local/lib`, etc.

Homebrew core repo formulae: downloaded to `/usr/local/Homebrew/Library/taps/homebrew/homebrew-core/formula`

## dmg
- Downie

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

