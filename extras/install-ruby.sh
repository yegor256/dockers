#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

ver=${RUBY_VERSION:-3.4.1}

apt-get update
apt-get install --yes --no-install-recommends \
  wget \
  build-essential \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  libyaml-dev \
  libgdbm-dev \
  libncurses5-dev \
  libffi-dev
apt-get clean
rm -rf /var/lib/apt/lists/*

cd /tmp
major_minor=$(echo "${ver}" | cut -d. -f1-2)
wget --quiet "https://cache.ruby-lang.org/pub/ruby/${major_minor}/ruby-${ver}.tar.gz"
tar -xzf "ruby-${ver}.tar.gz"
cd "ruby-${ver}"
./configure --disable-install-doc
make -j "$(nproc)"
make install
cd /
rm -rf "/tmp/ruby-${ver}"*

ruby --version
gem --version
