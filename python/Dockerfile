# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:0.0.1
LABEL description="RULTOR image for simple Python+Pip projects"
LABEL version="0.0.1"

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

# hadolint ignore=DL3003
RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    wget=* \
    build-essential=* \
    libssl-dev=* \
    zlib1g-dev=* \
    libbz2-dev=* \
    libreadline-dev=* \
    libsqlite3-dev=* \
    libncursesw5-dev=* \
    xz-utils=* \
    tk-dev=* \
    libxml2-dev=* \
    libxmlsec1-dev=* \
    libffi-dev=* \
    liblzma-dev=* \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && cd /tmp \
  && wget --quiet https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz \
  && tar -xzf Python-3.12.0.tgz \
  && cd Python-3.12.0 \
  && ./configure --enable-optimizations \
  && make -j "$(nproc)" \
  && make install \
  && cd / \
  && rm -rf /tmp/Python-3.12.0* \
  && ln -sf /usr/local/bin/python3 /usr/bin/python3 \
  && ln -sf /usr/local/bin/python3 /usr/bin/python \
  && ln -sf /usr/local/bin/pip3 /usr/bin/pip3 \
  && ln -sf /usr/local/bin/pip3 /usr/bin/pip \
  && echo "export PATH=\${PATH}:\${HOME}/.local/bin" >> "${HOME}/.profile" \
  && python3 --version \
  && pip3 --version
