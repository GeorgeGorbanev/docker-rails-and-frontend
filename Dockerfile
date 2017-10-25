FROM ruby:2.2.3
MAINTAINER GeorgeGorbanev <georgegorbanev@gmail.com>

RUN apt-get update && \
    apt-get -y install build-essential zlib1g-dev \
    libssl-dev libreadline6-dev libyaml-dev git \
    qt5-default libqt5webkit5-dev \
    gstreamer1.0-plugins-base \
    gstreamer1.0-tools gstreamer1.0-x \
    libgtk-3-dev

RUN groupadd --gid 1000 node && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV NODE_VERSION 6.7.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN npm install -g yarn

# Install firefox, geckodriver

RUN curl -L https://github.com/mozilla/geckodriver/releases/download/v0.19.0/geckodriver-v0.19.0-linux64.tar.gz | tar xz -C /usr/local/bin && \
    apt-get remove iceweasel && \
    cd /usr/local && \
    wget http://ftp.mozilla.org/pub/firefox/releases/56.0.1/linux-x86_64/en-US/firefox-56.0.1.tar.bz2 && \
    tar xvjf firefox-56.0.1.tar.bz2 && \
    ln -s /usr/local/firefox/firefox /usr/bin/firefox

CMD bash