#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

ruby --version
xcop --version
pdd --version
curl --version
wget --version
zip -h | head -1
unzip -h | head -1
ssh -V
git --version
docker --version
docker buildx version

gem install nokogiri

[ -e /usr/bin/install-postgres.sh ]
