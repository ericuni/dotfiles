#!/bin/zsh

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

function update_rust() {
  if [[ -z $os ]]; then
    echo "os unknown" >&2
    return 1
  fi

  rustup update
  rustup component add rust-src
  rustup component add rust-analyzer

  # [User Manual](https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary)
  if [[ $os == "mac" ]]; then
    url="https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-apple-darwin.gz"
  else
    url="https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz"
  fi

  curl -L $url | gunzip -c - >rust-analyzer
  chmod +x rust-analyzer
  mv rust-analyzer ~/.cargo/bin/
}

