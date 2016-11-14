FROM java:8-jre-alpine
MAINTAINER Owen Ouyang <owen.ouyang@live.com>

ENV SHELL=/bin/bash \
    WORK_USER="bzt" \
    WORK_HOME="/home/bzt" \
    user=bzt \
    group=bzt \
    uid=1000 \
    gid=1000 \
    DISPLAY=:20

#ADD http://chromedriver.storage.googleapis.com/2.25/chromedriver_linux64.zip /tmp
#ADD https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux64.tar.gz /tmp
#ADD https://dl-ssl.google.com/linux/linux_signing_key.pub /tmp

#ADD quick_test.yml /tmp
WORKDIR $WORK_HOME

RUN  cat << EOF > /tmp/quick_test.yml 
---
execution:
  - concurrency: 2
    ramp-up: 10s
    hold-for: 30s
    scenario: quick-test

scenarios:
  quick-test:
    requests:
      - http://blazedemo.com
EOF

RUN apk add --update --no-cache \
          lxdm \
          s6 \
          setxkbmap \
          udev \
          vino \
          xf86-input-evdev \
          xf86-input-keyboard \
          xf86-input-mouse \
          xfce4 \
          xinit \
          xorg-server \
          xvfb \
          libx11 \
          ttf-dejavu \
          unzip \
          gcc \
          make \
          git \
          bash \
          curl \
          wget \
          sudo \
          ruby ruby-dev \
          nodejs \
          chromium chromium-chromedriver \
          xrdp \
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
  gem install rspec && \
  addgroup -g ${gid} ${group} && \
  adduser -h "$WORK_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user} && \
  mkdir -p "$WORK_HOME" && chown ${user} "$WORK_HOME" && \
  echo "${WORK_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  rm -rf /var/cache/apk/* && \
  bzt /tmp/quick_test.yml && \
  rm -r $WORK_HOME/*-*-*_*-*-*.* && \
  chmod a+x .bzt/jmeter-taurus/bin/jmeter .bzt/jmeter-taurus/bin/jmeter-server .bzt/jmeter-taurus/bin/*.sh && \
  ln -s .bzt/jmeter-taurus/bin/jmeter && \
  ln -s .bzt/jmeter-taurus/bin/jmeter-server

#  gem install selenium-webdriver && \
#  apk add x11vnc --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/  --allow-untrusted && \
USER ${WORK_USER}

# Setup a password
#RUN x11vnc -storepasswd okmwsx12345E ~/.vnc/passwd
  
#Expose ports (VNC)
EXPOSE 3389


WORKDIR ${WORK_HOME}
