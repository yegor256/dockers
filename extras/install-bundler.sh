#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

if ! command -v gem >/dev/null 2>&1; then
    echo "gem not found, install Ruby first via install-ruby.sh" >&2
    exit 1
fi

ver=${BUNDLER_VERSION:-2.3.26}
gem_home=${GEM_HOME:-/usr/local/bundle}

echo 'gem: --no-document' >> "${HOME}/.gemrc"
gem install bundler -v "${ver}"
chmod a+w -R "${gem_home}"

bundler --version
