#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

apt-get --yes --fix-missing update
apt-get --yes --no-install-recommends install netpbm
apt-get clean
rm -rf /var/lib/apt/lists/*

pnmtopng --version
