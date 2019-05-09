FROM ubuntu:18.04

MAINTAINER mzxdream@gmail.com

#init
ENV TERM xterm-256color
ENV UHOME /root
USER root
RUN sed -i s@/archive.ubuntu.com/@/mirrors.163.com/@g /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        git \
        curl \
        ca-certificates \
        xz-utils
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
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
    && sed -i "$ a setopt no_nomatch" $UHOME/.zshrc \
    && sed -i "$ a export TERM=xterm-256color" $UHOME/.zshrc \
    && sed -i "s/ZSH_THEME=.*$/ZSH_THEME=\"tonotdo\"/g" $UHOME/.zshrc
#tmux
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tmux
COPY .tmux.conf $UHOME/.tmux.conf
#clang
COPY clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz /tmp/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
RUN cd /tmp \
    #&& curl -O -C 0 http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz \
    && tar xvJf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz \
    && cp -r clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/* /usr/local/bin/ \
    && cp -r clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04/lib/* /usr/local/lib/ \
    && cp -r clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04/include/* /usr/local/include/ \
    && rm -rf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04 clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
#vim
COPY vim /tmp/vim
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        gcc \
	make \
        liblua5.1-dev \
        luajit \
        libluajit-5.1 \
        python-dev \
        ruby-dev \
        libperl-dev \
        libncurses5-dev \
        ctags \
    #&& git clone --depth=1 https://github.com/vim/vim.git /tmp/ \
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
    && rm -rf ../vim
COPY .vimrc $UHOME/.vimrc
COPY .ycm_extra_conf.py $UHOME/.ycm_extra_conf.py
RUN curl -fLo $UHOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && vim --not-a-term -c "PlugInstall! | qall!"
#cpp
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        g++ \
	cmake
#clear
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/zsh"]
