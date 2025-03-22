#!/bin/zsh

brew update  ## Update homebrew itself and the package lists

brew upgrade --formula

if [[ `uname` == "Darwin" ]]; then
  # original brew can only pin formula not cask
  # [buo/homebrew-cask-upgrade](https://github.com/buo/homebrew-cask-upgrade) supports pinning cask
  # brew upgrade --cask --greedy
  # brew cu pin app
  brew cu -a
fi

brew cleanup

