#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

wget -qO- https://apt.llvm.org/llvm.sh | bash -s -- 19

if [ -e /usr/bin/clang ]; then
    rm -f /usr/bin/clang
fi
ln -s "$(which clang-19)" /usr/bin/clang

clang --version
