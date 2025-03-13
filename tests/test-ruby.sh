#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex

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
clang-19 --version

gem install nokogiri
