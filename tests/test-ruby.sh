#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex

ruby --version
xcop --version
curl --version
wget --version
zip -h
unzip -h
ssh -V
git --version

gem install nokogiri
