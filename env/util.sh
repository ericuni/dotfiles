#!/bin/zsh
set -x

function install_rust() {
  which cargo
  if [[ $? -ne 0 ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
      && . $HOME/.cargo/env && export CARGO_NET_GIT_FETCH_WITH_CLI=true
  fi
}

function install_rust_cmds() {
  for cmd in $@; do
    which $cmd
    if [[ $? -ne 0 ]]; then
      cargo install $cmd
    fi
  done
}

function install_rust_special_cmd() {
  cmd=$1
  pkg=$2

  which $cmd
  if [[ $? -ne 0 ]]; then
    cargo install $pkg
  fi
}

