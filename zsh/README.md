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

