FROM alpine:3.9

MAINTAINER mzxdream@gmail.com

#source
RUN echo "http://mirrors.aliyun.com/alpine/v3.9/main/" > /etc/apk/repositories
#timezone
ENV TIME_ZONE Asia/Shanghai
RUN apk add --no-cache -U tzdata \
        && ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime \
        && echo "${TIME_ZONE}" > /etc/timezone
#vim
RUN apk add --no-cache \
        build-base \
        ctags \
        git \
        libx11-dev \
        libxpm-dev \
        libxt-dev \
        make \
        ncurses-dev \
        python \
        python-dev \
        python3-dev \
    && git clone https://github.com/vim/vim \
    && cd vim \
    && ./configure \
        --disable-gui \
        --disable-netbeans \
        --enable-multibyte \
        --with-features=big \
        --enable-pythoninterp \
        --with-python-config-dir=/usr/lib/python2.7/config \
        --enable-python3interp \
        --with-python-config-dir=$(python3-config --configdir) \
    && make install
