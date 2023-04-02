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

# bazel
## https://bazel.build/install/ubuntu
## 组件名称"jdk1.8"仅因旧版原因而保留,与受支持或包含的 JDK 版本无关.Bazel 版本与 Java 版本无关.更改"jdk1.8"组件名称会破坏代码库的现有用户.
ADD bazel.gpg .
RUN apt install -y --no-install-recommends gnupg \
  && cat bazel.gpg | gpg --dearmor >bazel-archive-keyring.gpg \
  && mv bazel-archive-keyring.gpg /usr/share/keyrings \
  && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
  && apt update \
  && apt install -y --no-install-recommends bazel-5.4.0

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

