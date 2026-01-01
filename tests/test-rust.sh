#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

rustc --version
rustfmt --version
cargo --version
