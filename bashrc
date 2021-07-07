# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
export PS1="[\t \u@\H:\W]\$ "
export LC_CTYPE="en_US.UTF-8"
export LC="C"

## bash use emacs by default, change it to vi
set -o vi

export PATH=$PATH:/sbin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:${HOME}/git/note/bin
export PATH=$PATH:${HOME}/bin

user=`whoami`
uname -a | grep Darwin 1>/dev/null 2>&1
if [ $? -eq 0 ]
then
  export os="mac"
  export ip=`ifconfig en0 | grep inet | grep -v inet6 | awk '{print $2}'`
else
  export os="linux"
  export ip=`ifconfig eth0 | grep inet | grep -v inet6 | awk '{print $2}'`
fi
if [[ "x$os" == "xlinux" ]]
then
  export env=`systemd-detect-virt`
elif [[ "x$os" == "xmac" ]]
then
  export PATH=$PATH:"/usr/local/texlive/2020/bin/x86_64-darwin"
fi

ulimit -c unlimited

alias grep='grep --color=auto'
alias watch='watch -d -n 1'
alias tuer="ps x | fzf | awk '{print \$1}' | xargs kill -9"
alias tmux="TERM=screen-256color-bce tmux"

which fd >/dev/null
if [ $? -ne 0 ]
then
  alias fd="fdfind"
fi

alias ll="ls -l"
if [[ "x$os" == "xmac" ]]
then
  alias ls="ls -G"
else
  alias ls="ls --color=auto"
fi

export no_proxy="localhost,127.0.0.1,$ip"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[[ -f /usr/local/etc/profile.d/autojump.sh ]] && source /usr/local/etc/profile.d/autojump.sh # mac homebrew
[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh # linux

# blade
export BLADE_AUTO_UPGRADE="no"
alias bb="blade build"
alias bt="blade test"
alias br="blade run"
test -s ~/bin/bladefunctions && . ~/bin/bladefunctions || true

## go
export GOROOT="$HOME/opt/go"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOTMPDIR="/tmp/go"
if [ ! -d $GOTMPDIR ]
then
  mkdir $GOTMPDIR
fi
export PATH=$PATH:$GOROOT/bin:$GOBIN
export GO111MODULE=on
export GOPROXY="https://goproxy.io"

## node
if [ -d $HOME/opt/node ]
then
  export PATH="$PATH:$HOME/opt/node/bin"
fi

## java
export JAVA_HOME="$HOME/opt/jdk"
export PATH=$PATH:"$HOME/opt/jdk/bin"

# enterprise
if [ -f ~/.bashrc_enterprise ]; then
  source ~/.bashrc_enterprise
fi

# udf
## docker
if [ -f $HOME/git/docker/.dockerfunc ]
then
  source $HOME/git/docker/.dockerfunc
fi

function where() {
  env | grep VIMRUNTIME >/dev/null
  if [ $? -eq 0 ]
  then
    echo "vim"
  else
    echo "raw"
  fi
}
