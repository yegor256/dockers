#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

curl -fsSL https://deb.nodesource.com/setup_18.x | bash
apt-get install --yes nodejs

node --version
npm --version
