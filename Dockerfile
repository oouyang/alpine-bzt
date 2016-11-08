FROM java:alpine
MAINTAINER Owen Ouyang <owen.ouyang@live.com>

ENV SHELL=/bin/bash \
    WORK_USER="bzt" \
    WORK_HOME="/home/bzt" 

ARG user=$WORK_USER
ARG group=$WORK_USER
ARG uid=1000
ARG gid=1000

RUN apk add --update --no-cache \
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
  echo "${WORK_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ${WORK_USER}

WORKDIR ${WORK_HOME}
