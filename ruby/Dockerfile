# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM ruby:3.4-bullseye
LABEL Description="RULTOR image for simple Ruby projects (gems mostly)" Version="0.0.0"
WORKDIR /tmp

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y locales \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen \
  && update-locale LANG=en_US.UTF-8 \
  && echo "LC_ALL=en_US.UTF-8\nLANG=en_US.UTF-8\nLANGUAGE=en_US.UTF-8" > /etc/default/locale \
  && echo 'export LC_ALL=en_US.UTF-8' >> /root/.profile \
  && echo 'export LANG=en_US.UTF-8' >> /root/.profile \
  && echo 'export LANGUAGE=en_US.UTF-8' >> /root/.profile

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl=* wget=* \
    sudo=* \
    git=* \
    zip=* unzip=* \
    gnupg2=* \
    ssh=* \
    libcurl4-gnutls-dev=* \
    libxml2-utils=* \
    libjpeg-dev=* \
    build-essential=* \
    libmagic-dev=* \
    zlib1g-dev=* \
    openssl=* \
    lsb-release=* software-properties-common=* \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/download \
  && curl -s -L "https://download.docker.com/linux/static/stable/x86_64/docker-27.3.1.tgz" | tar -xz -C /tmp/download \
  && mv /tmp/download/docker/docker /usr/bin/ \
  && rm -rf /tmp/download

ENV GEM_HOME=/usr/local/bundle
RUN echo 'gem: --no-document' >> ~/.gemrc \
  && gem install bundler -v 2.3.26 \
  && gem install xcop -v 0.8.0 \
  && gem install pdd -v 0.23.1
RUN chmod a+w -R /usr/local/bundle

ENV PATH=$GEM_HOME/bin:$PATH
RUN echo "export PATH=$GEM_HOME/bin:\$PATH" >> $HOME/.profile
RUN echo 'export GEM_HOME=/usr/local/bundle' >> $HOME/.profile

COPY extras/ /usr/bin/
