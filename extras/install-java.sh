#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

ver=${JAVA_VERSION:-21}

apt-get --yes --fix-missing update
apt-get --yes --no-install-recommends install ca-certificates wget gpg
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public \
  | gpg --dearmor -o /usr/share/keyrings/adoptium.gpg
echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb bullseye main" \
  > /etc/apt/sources.list.d/adoptium.list
apt-get --yes update
apt-get --yes --no-install-recommends install "temurin-${ver}-jdk"
update-ca-certificates
apt-get clean
rm -rf /var/lib/apt/lists/*

arch=$(dpkg --print-architecture)
echo "export JAVA_HOME=/usr/lib/jvm/temurin-${ver}-jdk-${arch}" >> "${HOME}/.profile"

java -version
javac --version
