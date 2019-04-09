FROM ubuntu:18.04
MAINTAINER mzxdream@gmail.com

WORKDIR /tmp

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        locales \
        ca-certificates \
        git \
        vim \
        curl \
        cmake \
        python3-dev \
        ctags \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && git clone --depth=1 https://github.com/mzxdream/vimrc.git \
    && cp vimrc/.vimrc ~/.vimrc
