# plugins
插件管理器[Antigen](https://github.com/zsh-users/antigen)

[使用antigen轻松打造赏心悦目的shell环境](https://cloud.tencent.com/developer/article/1607239)

# emulate bash
[Return from emulate bash unsets zsh opts](
https://superuser.com/questions/1307205/return-from-emulate-bash-unsets-zsh-opts)

```shell
#!/bin/zsh

function run_in_bash {
  emulate -L bash
  ## bash script xxx
}
```

# rzsz
然后打开iTerm2 -> Preferences -> Profiles 选择 Advanced 设置 Triggers, 点击 Edit
点击+号, 每一项依次填:

- Regular expression填: `rz waiting to receive.\*\*B0100`
- Action选: `Run Silent Coprocess`
- Parameters填: `~/git/dotfiles/zsh/iterm2-send-zmodem.sh`
- Instant: 选中

再点击+号, 每一项依次填:

- Regular expression填: `\*\*B00000000000000`
- Action选: `Run Silent Coprocess`
- Parameters填: `~/git/dotfiles/zsh/iterm2-recv-zmodem.sh`
- Instant: 选中

