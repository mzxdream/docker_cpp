FROM centos:7

MAINTAINER mzxdream@gmail.com

#init
#ENV OWNER_NAME mzx
#ENV OWNER_PASSWORD 123
#RUN useradd -m ${OWNER_NAME} && usermod -aG wheel ${OWNER_NAME}

ENV TERM xterm-256color
USER root

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum makecache \
    && yum -y update
#language
RUN localedef -c -f UTF-8 -i en_US en_US.UTF-8
ENV LC_ALL "en_US.UTF-8"
#timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
#zsh
RUN yum -y install \
        git \
        curl \
        ca-certificates \
        zsh \
    && chsh -s /bin/zsh \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
    && sed -i "$ a setopt no_nomatch" /root/.zshrc \
    && sed -i "$ a export TERM=xterm-256color" /root/.zshrc \
    && sed -i "s/ZSH_THEME=.*$/ZSH_THEME=\"tonotdo\"/g" /root/.zshrc
#tmux
RUN yum -y install \
        tmux 
COPY .tmux.conf /root/.tmux.conf
#vim
RUN yum -y install \
        gcc \
        gcc-c++ \
        kernel-devel \
        readline-dev \
        ncurses \
        ncurses-devel \
        lua \
        lua-devel \
        git \
        python-devel \
        make \
    && git clone --depth=1 https://github.com/vim/vim.git \
    && cd vim \
    && ./configure \
        --disable-gui \
        --disable-netbeans \
        --with-features=big \
        --enable-multibyte \
        --enable-luainterp \
        --enable-pythoninterp \
        --with-python-config-dir=/usr/lib64/python2.7/config \
    && make install
#vim plug
COPY .vimrc /root/.vimrc
COPY .ycm_extra_conf.py /root/.ycm_extra_conf.py
RUN yum -y install \
        ctags \
        curl \
    && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && vim --not-a-term -c "PlugInstall! | qall!"
#end
RUN yum clean all
