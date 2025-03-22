# export proxy_ip="127.0.0.1"

function proxy() {
  local loc="$proxy_ip:8118"
  echo "with proxy $loc" >&2
  http_proxy=$loc https_proxy=$loc no_proxy="$no_proxy" $@
}

function switch_proxy() {
  # -z: zero
  if [[ -z $http_proxy ]]; then
    local loc="$proxy_ip:8118"
    export http_proxy=$loc
    export https_proxy=$loc
    echo "proxy $loc on" >&2
  else
    unset http_proxy
    unset https_proxy
    echo "proxy off" >&2
  fi
}

