#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

ver=${RUBY_VERSION:-3.4.9}
sha=${RUBY_DOWNLOAD_SHA256:-4231c54072601a171faed1699f105985e9971c94cd382b78feb4eb44eec2dd1a}

apt-get update
apt-get install --yes --no-install-recommends \
  ca-certificates \
  wget \
  xz-utils \
  dpkg-dev \
  build-essential \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  libyaml-dev \
  libgdbm-dev \
  libncurses-dev \
  libffi-dev
apt-get clean
rm -rf /var/lib/apt/lists/*

mkdir -p /usr/local/etc
echo 'gem: --no-document' >> /usr/local/etc/gemrc

cd /tmp
major_minor=$(echo "${ver}" | cut -d. -f1-2)
wget --quiet -O "ruby-${ver}.tar.xz" "https://cache.ruby-lang.org/pub/ruby/${major_minor}/ruby-${ver}.tar.xz"
echo "${sha} *ruby-${ver}.tar.xz" | sha256sum --check --strict
mkdir -p "/usr/src/ruby-${ver}"
tar -xJf "ruby-${ver}.tar.xz" -C "/usr/src/ruby-${ver}" --strip-components=1
cd "/usr/src/ruby-${ver}"
gnu_arch=$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)
./configure \
  --build="${gnu_arch}" \
  --disable-install-doc \
  --enable-shared
make -j "$(nproc)"
make install
ldconfig
cd /
rm -rf "/usr/src/ruby-${ver}" "/tmp/ruby-${ver}.tar.xz"

ruby --version
gem --version
