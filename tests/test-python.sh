#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

python --version
pip --version

python3 --version
pip3 --version

pip3 install flake8
flake8 --version
