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
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata
#zsh
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        zsh \
    && rm -rf /var/lib/apt/lists/* \
    && chsh -s /bin/zsh \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
COPY .zshrc /root/.zshrc
#tmux
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tmux \
    && rm -rf /var/lib/apt/lists/*
COPY .tmux.conf /root/.tmux.conf
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
        python3-dev \
        ctags \
        clang-7 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-7 1 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-7 \
    && rm -rf /var/lib/apt/lists/*
COPY .vimrc /root/.vimrc
COPY .ycm_extra_conf.py /root/.ycm_extra_conf.py
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && vim --not-a-term -c "PlugInstall! | qall!"

ENTRYPOINT ["/usr/bin/zsh"]
