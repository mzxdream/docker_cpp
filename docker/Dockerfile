FROM ubuntu:18.04
MAINTAINER mzxdream@gmail.com

#change source
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get clean
#language
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        locales \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
#timezone
ENV TZ 'Asia/shanghai'
RUN echo $TZ > /etc/timezone \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && rm /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata
#vim
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        git \
        vim \
        curl \
        cmake \
        python-dev \
        ctags \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && git clone --depth=1 https://github.com/mzxdream/vimrc.git \
    && cp vimrc/.vimrc ~/.vimrc \
    && rm -rf vimrc \
    && vim --not-a-term -c "PlugInstall! | qall!" \
    && cd /root/.vim/plugged/YouCompleteMe \
    && python install.py
