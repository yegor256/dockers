#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

apt-get update --yes --fix-missing
apt-get install apache2-utils
apt-get clean

ab -V
