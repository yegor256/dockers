#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

ver=${GRADLE_VERSION:-9.0.0}

if ! command -v javac >/dev/null 2>&1; then
    echo "javac not found, install Java first via install-java.sh" >&2
    exit 1
fi

wget -q "https://services.gradle.org/distributions/gradle-${ver}-bin.zip" -P /tmp
unzip -d /opt "/tmp/gradle-${ver}-bin.zip"
chmod a+x "/opt/gradle-${ver}/bin/gradle"
ln -s "/opt/gradle-${ver}/bin/gradle" /usr/bin/gradle
echo "export PATH=\${PATH}:/opt/gradle-${ver}/bin" >> "${HOME}/.profile"

gradle --version
