#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

apt-get update --yes --fix-missing
apt-get install --yes chromium-driver

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/chrome-keyring.gpg
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
apt-get update --yes --fix-missing
# Install the real libasound2 first, so packages that depend on it (e.g.
# temurin-*-jdk) keep their dependency satisfied. Otherwise removing the
# oss4 packages below cascades into removing the JDK, breaking JAVA_HOME
# (see #55, regression from #53).
apt-get install --yes libasound2
apt-get remove --yes liboss4-salsa-asound2 liboss4-salsa2
apt-get install --yes google-chrome-stable
apt-get remove --yes --purge chromium-driver
apt-get clean

google-chrome --version
/usr/bin/google-chrome --version
