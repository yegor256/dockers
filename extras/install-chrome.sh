#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

apt-get update --yes --fix-missing
apt-get install --yes chromium-driver

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/chrome-keyring.gpg
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
apt-get update --yes --fix-missing
apt-get install --yes google-chrome-stable
apt-get remove --yes --purge chromium-driver
apt-get clean

google-chrome --version
/usr/bin/google-chrome --version
