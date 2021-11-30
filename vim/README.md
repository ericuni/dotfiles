- [2020年vim的C/C++配置](https://www.jianshu.com/p/249850f2cc64)

# conf dir
`vim/after/` directory is a bit of a hack. Files in this directory will be loaded every time Vim starts, but after the
files in `~/.vim/plugin/`. This allows you to override Vim's internal files.

# vimrc
vim 自带有很多快捷键,再加上各类插件的快捷键,大量快捷键出现在单层空间中难免引起冲突,为缓解该问题,引入了前缀键 `<leader>`,
键r 可以配置成r, `<leader>r, <leader><leader>r` 等等多个快捷键.前缀键是 vim 使用率较高的一个键(最高的当属 Esc),选一个最方
便输入的键作为前缀键,将有助于提高编辑效率.找个无须眼睛查找,无须移动手指的键 - 分号键,挺方便的,就在你右手小指处:
```vim
" 定义快捷键的前缀,即<Leader>
let mapleader=";"
```

使用下表中不同形式的map命令,可以针对特定的模式设置键盘映射:

| Command命令 | 常规模式 | 可视化模式 | 运算符模式 | 插入模式 | 命令行模式 |
| ---         | ---      | ---        | ---        | ---      | ---        |
| :map        | √        | √          | √          |          |            |
| :nmap       | √        |            |            |          |            |
| :vmap       |          | √          |            |          |            |
| :omap       |          |            | √          |          |            |
| :map!       |          |            |            | √        | √          |
| :imap       |          |            |            | √        |            |
| :cmap       |          |            |            |          | √          |

nore: 表示非递归 not recursion

`:nmap`: 列出所有键盘映射

# vim script
[vim scripting cheatsheet](https://devhints.io/vimscript)

# nvim
install
```bash
sudo apt-get install libtool-bin python3-pip
pip2 install --user --upgrade pynvim
pip3 install --user --upgrade pynvim
npm install -g neovim
```

check
```
:checkhealth
```

# plugin
[将 VIM 打造成 go 语言的 ide](https://learnku.com/articles/24924)

[junegunn/vim-plug](https://github.com/junegunn/vim-plug)

安装gcc
```bash
./configure --disable-multilib
```

说是需要GMP 4.2+, MPFR 2.4.0+, MPC 0.8.0+, gcc 安装包里已经提供了下载方式, 可以直接用
```bash
sh ./contrib/download_prerequisites
```
也可以通过包管理系统来安装
```bash
sudo apt-get install libgmp-dev libmpfr-dev libmpc-dev flex
```

对 vim 的版本有要求, 且需要vim 支持python 3.[Vim 8 支持 Python 3 的一些坑](https://toutiao.io/posts/runvgs/preview)

1. 安装node, 下载linux binary version, 建个软链, 放到$PATH 就行了.
1. python3 的版本不用安装最新的, 我的机器上 Python 3.5.3 就行了.
1. 安装vim, 下载最新版源代码

	```bash
	sudo apt install libpython3-dev libncurses5-dev
	./configure --enable-python3interp=yes
	```

注:

- 安装libncurses5-dev 的原因, [编译vim no terminal library found](
  https://blog.csdn.net/cuijianzhi/article/details/78652745)

## [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim)
需要fzf 版本至少0.24, 通过apt-get 安装的版本比较低, 所以需要通过vim-plug 安装最新版
```vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
```

Most commands support CTRL-T / CTRL-X / CTRL-V key bindings to open in a new tab, a new split, or in a new vertical split

fzf 配置使用fd 代替默认的 find 来之行搜素, 对 color 在mac, linux, docker 上还没完全配置正确.
```bash
export FZF_DEFAULT_COMMAND='fd --color=always --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
```

## [junegunn/vim-easy-align](https://github.com/junegunn/vim-easy-align)

## [preservim/nerdcommenter](https://github.com/preservim/nerdcommenter)
- `[count]<leader>cc`: 注释从当前行往下数的 count 行,count 可省略,默认值为 1 (cc 是 NERDCommenterComment 的缩写).
- `[count]<leader>cu`: 取消注释从当前行往下数的 count 行,count 可省略,默认值为 1 (cu 是 NERDCommenterUncomment 的缩写)
- `[count]<leader>ci`: 切换从当前行往下数的 count 行的注释状态 (ci 是 NERDCommenterInvert 的缩写).
- `<leader>c$`: 注释掉从当前光标所在位置到行尾的剩下内容,等价于在光标所在位置插入注释符(c$ 表示NERDCommenterToEOL 的缩写.
- `<leader>cA`: 在光标所在当前行行尾添加注释符号并进入Vim 的插入模式(cA 是NERDCommenterAppend 的缩写).

## [preservim/nerdtree](https://github.com/preservim/nerdtree)
Pressing m would open a menu below and you can select from a list of actions.

```info
NERDTree Menu. Use j/k/enter and the shortcuts indicated
==========================================================
> (a)dd a childnode
  (m)ove the current node
  (d)elete the current node
  (r)eveal in Finder the current node
  (o)pen the current node with system editor
  (q)uicklook the current node
  (c)opy the current node
Add a childnode
==========================================================
Enter the dir/file name to be created. Dirs end with a '/'
/Library/WebServer/Documents/new-teacher-center/app/Model/
```

## [ianva/vim-youdao-translater](https://github.com/ianva/vim-youdao-translater)
- 在普通模式下,按 ctrl+t, 会翻译当前光标下的单词;
- 在 visual 模式下选中单词或语句,按 ctrl+t, 会翻译选择的单词或语句;
- `<leader>yd` 可以在命令行输入要翻译的单词或语句.

译文将会在编辑器底部的命令栏显示.

## [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim)
need node

- `:CocList services`
- `:CocList sources`

| command      | description |
| ---          | ---         |
| `<leader>rn` | rename      |

### [coc-snippets](https://github.com/neoclide/coc-snippets)
- `<C-j>`: Trigger key for going to the next snippet position, applied in insert and select mode.
  Only works when snippet session is activated.
- `<C-k>`: Trigger key for going to the previous snippet position, applied in insert and select mode.
  Only works when snippet session is activated.

[vim 入坑指南(六)插件 UltiSnips](https://vimzijun.net/2016/10/30/ultisnip/)

```
snippet 关键词 "说明" 设定
内容
endsnippet
```

设定

- b 代表只有关键词出现在行首的时候,才可以被展开
- A 代表自动展开
- w 代表可以展开这个 "词",具体 "词" 的定义可以查看 :help iskeyword.直观感觉就是,这个关键词是单独的,和其他文字分开的.比如
  前后都是空格.
- i 代表可以忽略前后字节,直接展开关键词.(这个设定比 w 要更松)
- 其他的还有r, s, t, m 等等,都可以通过这个命令在自带文档里找到

`${1:Class}` 就是代表可以替换的内容,如果不替换的话则会显示冒号后面的内容,在这个例子是就是 Class

### [coc-marketplace](https://github.com/fannheyward/coc-marketplace)
`:CocList marketplace`: 进入marketplace

### language server
[Debug language server](https://github.com/neoclide/coc.nvim/wiki/Debug-language-server)

#### go
coc-go 和 languageserver.golang 只能使用其中的一个, 否则自动补全的时候会重复提示.
[Duplicate Suggestions in autocompletion](https://github.com/neoclide/coc.nvim/issues/1824)

```json
{
  "languageserver": {
    "golang": {
      "command": "gopls",
      "args": ["-remote=auto", "-listen.timeout=1h", "-remote.listen.timeout=2h"],
      "rootPatterns": ["go.mod"],
      "trace.server": "verbose",
      "filetypes": ["go"],
      "initializationOptions": {
        "usePlaceholders": true,
        "completeUnimported": true
      }
    }
  }
}
```

[jstemmer/gotags](https://github.com/jstemmer/gotags)

#### cpp
- ccls 可以在只打开一个头文件的情况下, 跳转到实现的地方, 而clangd 需要先把实现文件也打开才能正常跳转
- 同一个仓库下不同文件的同名的class, ccls 会错误地当成一个类型

所以需要根据具体场景适当选择

##### ccls
安装, https://github.com/MaskRay/ccls/wiki/Build

1. cmake, 使用 https://cmake.org/download/ 上的 ``make-3.22.0-linux-x86_64.sh` 就行, 然后通过软链
1. clang+llvm, 使用 https://github.com/llvm/llvm-project/releases 上的 `clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz` 就可以
1. 编译 ccls
  ```
  cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-16.04
  cmake --build Release
  ```
1. 将编译出的 Release/ccls 拷贝到某个$PATH 目录下, 比如 `~/bin`

发现在编译安装期间, /usr/lib/x86_64-linux-gnu/libstdc++.so.6 经常被重新指向一个旧的, 需要手动重新指向新的
[Where can I find GLIBCXX_3.4.29?](https://stackoverflow.com/questions/65349875/where-can-i-find-glibcxx-3-4-29)
```
sudo find / -name "libstdc++.so*"  // 会找到包括/usr/local/lib64/libstdc++.so.6.0.29 在内的很多文件
sudo ln -sf /usr/local/lib64/libstdc++.so.6.0.29 /usr/lib/x86_64-linux-gnu/libstdc++.so.6
```

[编译安装ccls](https://edward852.github.io/post/编译安装ccls/)

##### clangd
coc-clangd 和 languageserver.clangd 也只能用一个.

#### latex
[coc-texlab](https://github.com/fannheyward/coc-texlab)

digestif 不好用

## [liuchengxu/vista.vim](https://github.com/liuchengxu/vista.vim)
| Command | Description                                       |
| ---     | ---                                               |
| Vista   | Open vista window for viewing tags or LSP symbols |
| Vista!  | Close vista view window if already opened         |
| Vista!! | Toggle vista view window                          |

- :Vista [EXECUTIVE]: open vista window powered by EXECUTIVE.
- :Vista finder [EXECUTIVE]: search tags/symbols generated from EXECUTIVE in fzf mode

