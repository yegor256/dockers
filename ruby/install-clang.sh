#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

wget -qO- https://apt.llvm.org/llvm.sh | bash -s -- 19

ln -s "$(which clang-19)" /usr/bin/clang
clang --version
