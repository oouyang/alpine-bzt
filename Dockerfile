FROM java:8-jre-alpine
MAINTAINER Owen Ouyang <owen.ouyang@live.com>

ENV SHELL=/bin/bash \
    WORK_USER="bzt" \
    WORK_HOME="/root/bzt" \
    user=bzt \
    group=bzt \
    uid=1000 \
    gid=1000 

COPY quick_test.yml /root/

WORKDIR $WORK_HOME

RUN apk add --update --no-cache \
            lxdm \
            setxkbmap \
            udev \
            vino \
            unzip \
            build-base \
            git \
            bash \
            curl \
            wget \
            sudo \
            ruby \
            nodejs \
            python-dev \
            py-pip \
            py-psutil \
            icu-dev \
            openssl-dev \
            bzip2-dev \
            fuse-dev \
            musl-dev \
            libxml2-dev \
            libxslt-dev \
            linux-headers && \
  pip install --upgrade pip setuptools && \
  pip install bzt locustio selenium && \
  pip install --upgrade selenium && \
  npm install -g mocha && \
  mkdir -p "$WORK_HOME" \
  rm -rf /var/cache/apk/* && \
  bzt /root/quick_test.yml && \
  apk del build-base musl-dev bzip2-dev openssl-dev \
          linux-headers libxslt-dev \
          fuse-dev icu-dev python-dev ruby-dev && \
  mkdir /root/bzt

