# export proxy_loc="127.0.0.1:8118"

function proxy() {
  echo "with proxy $proxy_loc" >&2
  http_proxy=$proxy_loc https_proxy=$proxy_loc no_proxy="$no_proxy" $@
}

function switch_proxy() {
  # -z: zero
  if [[ -z $http_proxy ]]; then
    export http_proxy=$proxy_loc
    export https_proxy=$proxy_loc
    echo "proxy $loc on" >&2
  else
    unset http_proxy
    unset https_proxy
    echo "proxy off" >&2
  fi
}

