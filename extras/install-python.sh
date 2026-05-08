#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

ver=${PYTHON_VERSION:-3.12.0}

apt-get update
apt-get install --yes --no-install-recommends \
  wget \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  xz-utils \
  tk-dev \
  libxml2-dev \
  libxmlsec1-dev \
  libffi-dev \
  liblzma-dev
apt-get clean
rm -rf /var/lib/apt/lists/*

cd /tmp
wget --quiet "https://www.python.org/ftp/python/${ver}/Python-${ver}.tgz"
tar -xzf "Python-${ver}.tgz"
cd "Python-${ver}"
./configure --enable-optimizations
make -j "$(nproc)"
make install
cd /
rm -rf "/tmp/Python-${ver}"*

ln -sf /usr/local/bin/python3 /usr/bin/python3
ln -sf /usr/local/bin/python3 /usr/bin/python
ln -sf /usr/local/bin/pip3 /usr/bin/pip3
ln -sf /usr/local/bin/pip3 /usr/bin/pip

echo "export PATH=\${PATH}:\${HOME}/.local/bin" >> "${HOME}/.profile"

python3 --version
pip3 --version
