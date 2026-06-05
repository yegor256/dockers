#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

ver=${MAVEN_VERSION:-3.9.9}

if ! command -v javac >/dev/null 2>&1; then
    echo "javac not found, install Java first via install-java.sh" >&2
    exit 1
fi

m2_home="/usr/local/apache-maven/apache-maven-${ver}"
echo "export M2_HOME=${m2_home}" >> "${HOME}/.profile"

cd /tmp
wget --quiet "https://archive.apache.org/dist/maven/maven-3/${ver}/binaries/apache-maven-${ver}-bin.tar.gz"
mkdir -p /usr/local/apache-maven
mv "apache-maven-${ver}-bin.tar.gz" /usr/local/apache-maven
tar xzvf "/usr/local/apache-maven/apache-maven-${ver}-bin.tar.gz" -C /usr/local/apache-maven/
update-alternatives --install /usr/bin/mvn mvn "${m2_home}/bin/mvn" 1
update-alternatives --config mvn

mvn -ntp dependency:get -Dartifact=junit:junit:4.11

mvn --version
