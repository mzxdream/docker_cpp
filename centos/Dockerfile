FROM centos:7

MAINTAINER mzxdream@gmail.com

#source
COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
RUN yum makecache \
    && yum -y update
#language
RUN yum -y install kde-l10n-Chinese telnet \
    && yum -y reinstall glibc-common \
    && yum clean all \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ENV LC_ALL "zh_CN.UTF-8"
#timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
#zsh
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
