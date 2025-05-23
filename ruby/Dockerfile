# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM ruby:3.4-bullseye
LABEL description="RULTOR image for simple Ruby projects (gems mostly)"
LABEL version="0.0.1"

WORKDIR /tmp

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

ENV DEBIAN_FRONTEND=noninteractive

ENV HOME=/root

RUN apt-get update && apt-get install --yes --no-install-recommends locales=* \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen \
  && update-locale LANG=en_US.UTF-8 \
  && printf 'LC_ALL=en_US.UTF-8\nLANG=en_US.UTF-8\nLANGUAGE=en_US.UTF-8\n' > /etc/default/locale \
  && printf 'export LC_ALL=en_US.UTF-8\n' >> "${HOME}/.profile" \
  && printf 'export LANG=en_US.UTF-8\n' >> "${HOME}/.profile" \
  && printf 'export LANGUAGE=en_US.UTF-8\n' >> "${HOME}/.profile" \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    curl=* wget=* \
    sudo=* \
    git=* \
    zip=* unzip=* \
    gnupg2=* \
    ssh=* \
    tree=* \
    jq=* \
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
  && gem install pdd -v 0.23.1 \
  && chmod a+w -R /usr/local/bundle

ENV PATH=${GEM_HOME}/bin:${PATH}
RUN echo "export PATH=${GEM_HOME}/bin:\${PATH}" >> "${HOME}/.profile" \
  && echo "export GEM_HOME=${GEM_HOME}" >> "${HOME}/.profile"

COPY extras/ /usr/bin/
