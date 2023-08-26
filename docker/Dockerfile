FROM ubuntu:latest

# env
RUN apt update \
  && export LC_ALL=C \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt install -y --no-install-recommends apt-utils locales-all tzdata \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && dpkg-reconfigure --frontend noninteractive tzdata

# tool
RUN apt install -y --no-install-recommends \
  openssl ca-certificates systemd \
  zsh python3-neovim git git-lfs less \
  tree file \
  curl net-tools iproute2 iputils-ping \
  strace linux-tools-generic sysstat \
  && ln -sf /usr/lib/linux-tools/5.13.0-25-generic/perf /usr/bin/perf \
  && ulimit -c unlimited

# lang and library
RUN apt install -y --no-install-recommends \
  build-essential gcc g++ make cmake gdb clang-format ccls clangd \
  libprotobuf-dev libprotoc-dev protobuf-compiler \
  libgoogle-glog-dev libgflags-dev libgtest-dev libgmock-dev libbenchmark-dev libgoogle-perftools-dev \
  libleveldb-dev \
  libev-dev libevent-dev libjsoncpp-dev libssl-dev libcurl4-openssl-dev \
  zlib1g-dev libsnappy-dev \
  python3 libpython3-dev python3-pip

# ssh
# `service ssh status|start|stop`
RUN apt install -y --no-install-recommends openssh-server \
  && echo 'root:123456' | chpasswd \
  && sed -i '/PermitRootLogin prohibit-password/c PermitRootLogin yes' /etc/ssh/sshd_config
EXPOSE 22

# mysql
# RUN apt-get install -y mysql-server mysql-client

# redis
# RUN apt-get install -y redis
# EXPOSE 6379

