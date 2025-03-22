
export JOSHUTO_CONFIG_HOME="$HOME/git/dotfiles/joshuto"

# .envrc only supports export for now, example
# #!/bin/zsh
# export GOROOT=$(go1.21.13 env GOROOT)
# export PATH=$GOROOT/bin:$PATH
which direnv >/dev/null
if [[ $? -eq 0 ]]; then
  eval "$(direnv hook zsh)"
fi

# docker machine
function dm() {
  if [[ $1 == "init" ]]; then
    name=$2
    if [[ -z $name ]]; then
      echo "name invalid" >&2
      return 1
    fi
    home="$HOME/.container"
    if [[ ! -d $home ]]; then
      mkdir $home
    fi

    image=`docker images | grep ubuntu | grep latest | awk '{print $1":"$2}' | sort -r | head -n 1`
    echo "image $image used" >&2

    ## http://stackoverflow.com/questions/35860527/warning-error-disabling-address-space-randomization-operation-not-permitted/35860616
    docker run -dt \
      -v $home:/root \
      -v $HOME:/root/host \
      -w /root \
      -p 8022:22 \
      --privileged \
      --security-opt seccomp=unconfined \
      --hostname $name \
      --name $name \
      $image
  elif [[ $1 == "clear" ]]; then
    docker ps -a | grep -v dev | grep -v "CONTAINER ID" | awk '{print $1}' | xargs docker rm
  else
    docker exec -it $1 /bin/zsh
  fi
}

# texlive
p="/usr/local/texlive/2020"
if [[ -d $p ]]; then
  append_path "$p/bin/x86_64-darwin"
  export INFOPATH="$p/texmf-dist/doc/info:$INFOPATH"
fi

function clean() {
  emulate -L bash

  ## latex
  rm *.aux *.bbl *.blg *.lof *.lot *.toc *.thm *.snm *.vrb *.nav *.fdb_latexmk *.fls, *.pre 2>/dev/null

  ## glog
  rm *.`hostname`.`whoami`.* 2>/dev/null
  for file in `ls *.INFO *.WARNING *.ERROR *.FATAL`
  do
    if [ -L $file ]; then
      rm $file
    fi
  done 2>/dev/null

  for file in `ls *.out *.log`
  do
    ## preserve nohup.out and err.log
    if [[ "x$file" == "xnohup.out" || "x$file" == "xerr.log" ]]; then
      continue
    fi
    rm $file
  done 2>/dev/null
}

function pdf() {
  if [ $# -ne 1 ]; then
    echo "no file" >&2
    return 1
  fi

  tex=`echo $1 | awk -F. '{print $1}'`

  xelatex $tex
  if [[ -d asytmp ]]; then
    cd asytmp
    asy $tex-*.asy || return 1
    cd -
  fi
  bibtex $tex
  xelatex $tex
  xelatex $tex  ## update cref
}

