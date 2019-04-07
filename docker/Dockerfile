FROM ubuntu:18.04
MAINTAINER mzxdream@gmail.com

WORKDIR /tmp

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && apt-get install -y \
        git \
        vim \
        curl \
    && rm -rf /var/lib/apt/lists/*
