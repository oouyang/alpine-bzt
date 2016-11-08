FROM java:alpine
MAINTAINER Owen Ouyang <owen.ouyang@live.com>

ENV SHELL=/bin/bash \
    WORK_USER="bzt" \
    WORK_HOME="/home/bzt" 

apk add --update --no-cache \
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
  pip install bzt 

# add user
RUN groupadd -r ${WORK_USER} -g 1000 && useradd -r -u 1000 -s /bin/bash -m -g ${WORK_USER} ${WORK_USER}
RUN echo "${WORK_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER ${WORK_USER}

WORKDIR ${WORK_HOME}
