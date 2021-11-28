#!/bin/zsh
# some useful bazel shell functions

_find_target_dir () {
  target=$1
  local dir
  dir=$PWD;
  while [ "$dir" != "/" ]; do
    if [ -f "$dir/$target" ]; then
      echo "$dir"
      return 0
    fi;
    dir=`dirname "$dir"`
  done
  return 1
}

# cd to source directory
# /root/.cache/bazel/_bazel_root/8e9828f0dbad205e153f2609bf02fc51/execroot/com_github_ericuni_code/bazel-out/k8-fastbuild/bin/thirdparty/curl
# /root/git/code/bazel-bin/thirdparty/curl
function cdsrc() {
  local root
  local relpath

  local pattern1="bazel-out/k8-fastbuild/bin"
  local pattern2="bazel-bin"
  if [[ $PWD =~ $pattern1 ]]; then
    local index="DO_NOT_BUILD_HERE"
    local dir=`_find_target_dir $index`
    root=`head -n 1 $dir/$index`
    relpath=`echo $PWD | awk -F $pattern1 '{print $NF}'`
    cd $root/$relpath
    return $?
  elif [[ $PWD =~ $pattern2 ]]; then
    root=`echo $PWD | awk -F $pattern2 '{print $1}'`
    relpath=`echo $PWD | awk -F $pattern2 '{print $NF}'`
    cd $root/$relpath
    return $?
  fi
  return 1
}

# cd to build directory
function cddst() {
  local root
  local relpath

  ## if WORKSPACE found, then we are in src
  if root=`_find_target_dir WORKSPACE`; then
    relpath=`echo $PWD | awk -F $root '{print $NF}'`
    cd $root/bazel-bin/$relpath
    return $?
  fi
  return 1
}

# switch between src and dst directory
function alt() {
  if ! cdsrc; then cddst; fi
}

alias a=alt

