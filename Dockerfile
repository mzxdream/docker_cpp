FROM ubuntu:18.04

MAINTAINER mzxdream@gmail.com

#init
ENV TERM=xterm-256color \
    UHOME=/root
#ARG HTTP_PROXY_ARG="socks5://host.docker.internal:1080"
#ARG HTTPS_PROXY_ARG="socks5://host.docker.internal:1080"
#ARG CURL_ARG="curl --socks5 host.docker.internal:1080"
ARG CURL_ARG="curl"
USER root
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        git \
        curl \
        ca-certificates \
        xz-utils \
        make \
        cmake \
        gcc \
        g++ \
        gdb \
    && git config --global user.name mzxdream \
    && git config --global user.email mzxdream@gmail.com \
    && test -z "$HTTP_PROXY_ARG" || git config --global http.proxy $HTTP_PROXY_ARG && : \
    && test -z "$HTTPS_PROXY_ARG" || git config --global https.proxy $HTTPS_PROXY_ARG && : \
    && git config --global credential.helper store
#language
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
#timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata
#zsh
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        zsh \
    && chsh -s /bin/zsh \
    && sh -c "$($CURL_ARG -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
    && sed -i "$ a setopt no_nomatch" $UHOME/.zshrc \
    && sed -i "$ a export TERM=xterm-256color" $UHOME/.zshrc \
    && sed -i "s/ZSH_THEME=.*$/ZSH_THEME=\"tonotdo\"/g" $UHOME/.zshrc
#tmux
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tmux
COPY .tmux.conf $UHOME/.tmux.conf
#clang
COPY clang/include /usr/local/include/
COPY clang/lib /usr/local/lib/
COPY clang/bin /usr/local/bin/
#vim
#COPY vim /tmp/vim
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        liblua5.1-dev \
        luajit \
        libluajit-5.1 \
        python-dev \
        ruby-dev \
        libperl-dev \
        libncurses5-dev \
        automake \
        pkg-config \
        python-pip \
    && pip install requests \
    && git clone --depth=1 https://github.com/vim/vim.git /tmp/vim \
    && cd /tmp/vim \
    && ./configure --with-features=huge \
        --disable-gui \
        --disable-netbeans \
        --enable-multibyte \
        --enable-rubyinterp \
        --enable-largefile \
        --enable-pythoninterp \
        --with-python-config-dir=$(python2.7-config --configdir) \
        --enable-perlinterp \
        --enable-luainterp \
        --enable-fail-if-missing \
        --with-luajit \
        --with-lua-prefix=/usr \
        --enable-cscope \
    && make install \
    && rm -rf /tmp/vim
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        global \
    && pip install pygments \
    && git clone --depth=1 https://github.com/universal-ctags/ctags.git /tmp/ctags \
    && cd /tmp/ctags \
    && sh autogen.sh \
    && ./configure \
    && make install \
    && rm -rf /tmp/ctags
COPY .vimrc $UHOME/.vimrc
COPY .ycm_extra_conf.py $UHOME/.ycm_extra_conf.py
RUN $CURL_ARG -fLo $UHOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && vim --not-a-term -c "PlugInstall! | qall!"
#clear
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/zsh"]
#docker run --name mzx --privileged --net=host -dit mzx:v1
