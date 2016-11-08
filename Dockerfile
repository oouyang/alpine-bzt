FROM java:alpine
MAINTAINER Owen Ouyang <owen.ouyang@live.com>

ENV SHELL=/bin/bash \
    WORK_USER="bzt" \
    WORK_HOME="/home/bzt" \
    user=bzt \
    group=bzt \
    uid=1000 \
    gid=1000 

#ADD http://chromedriver.storage.googleapis.com/2.25/chromedriver_linux64.zip /tmp
#ADD https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux64.tar.gz /tmp
#ADD https://dl-ssl.google.com/linux/linux_signing_key.pub /tmp

RUN apk add --update --no-cache \
          xvfb \
          libx11 \
          unzip \
          gcc \
          bash \
          curl \
          wget \
          sudo \
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
  pip install bzt && \
  addgroup -g ${gid} ${group} && \
  adduser -h "$WORK_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user} && \
  echo "${WORK_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    apk add --update x11vnc --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted && \
    apk add --update chromium chromium-chromedriver --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted && \
    rm -rf /var/cache/apk/*
  

USER ${WORK_USER}

WORKDIR ${WORK_HOME}
