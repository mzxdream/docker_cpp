FROM ubuntu:18.04
MAINTAINER mzxdream@gmail.com

WORKDIR /tmp

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        vim \
        curl \
        cmake \
        python3-dev \
        ctags \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && git clone --depth=1 https://github.com/mzxdream/vimrc.git \
    && cp vimrc/.vimrc ~/.vimrc
