# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM ubuntu:24.04
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
    autoconf=* \
    automake=* \
    build-essential=* \
    ca-certificates=* \
    curl=* wget=* \
    git=* \
    gnupg2=* \
    jq=* \
    libcurl4-gnutls-dev=* \
    libjpeg-dev=* \
    libmagic-dev=* \
    libtool=* \
    libxml2-utils=* \
    lsb-release=* \
    openssl=* \
    software-properties-common=* \
    ssh=* \
    sudo=* \
    tree=* \
    unzip=* \
    zip=* \
    zlib1g-dev=* \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && (getent group ssh > /dev/null || groupadd --system ssh)

# Note if the base image changes, then these versions need to be adjusted
# along with the noble release name
ARG DOCKER_VERSION=5:29.2.1-1~ubuntu.24.04~noble
ARG DOCKER_CLI_VERSION=5:29.2.1-1~ubuntu.24.04~noble
ARG CONTAINERD_VERSION=2.2.1-1~ubuntu.24.04~noble
ARG BUILDX_VERSION=0.31.1-1~ubuntu.24.04~noble
ARG COMPOSE_VERSION=5.1.0-1~ubuntu.24.04~noble

RUN mkdir -p /etc/apt/keyrings/ \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc \
  && chmod a+r /etc/apt/keyrings/docker.asc \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu noble stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
  && apt-get update \
  && apt-get --yes --no-install-recommends install \
    docker-ce=${DOCKER_VERSION} \
    docker-ce-cli=${DOCKER_CLI_VERSION} \
    containerd.io=${CONTAINERD_VERSION} \
    docker-buildx-plugin=${BUILDX_VERSION} \
    docker-compose-plugin=${COMPOSE_VERSION} \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY extras/ /usr/bin/

ENV RUBY_VERSION=3.4.9
RUN /usr/bin/install-ruby.sh

ENV GEM_HOME=/usr/local/bundle
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV BUNDLE_APP_CONFIG=${GEM_HOME}
RUN mkdir -p "${GEM_HOME}" \
  && chmod 1777 "${GEM_HOME}" \
  && /usr/bin/install-bundler.sh \
  && gem install xcop -v 0.8.0 \
  && gem install pdd -v 0.23.1 \
  && chmod a+w -R /usr/local/bundle

ENV PATH=${GEM_HOME}/bin:${PATH}
RUN echo "export PATH=${GEM_HOME}/bin:\${PATH}" >> "${HOME}/.profile" \
  && echo "export GEM_HOME=${GEM_HOME}" >> "${HOME}/.profile"
