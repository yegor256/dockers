#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

depends=$1

if [ ! -e "${depends}" ]; then
    echo "The file is absent: ${depends}"
    exit 1
fi

tlmgr option repository ---URL---
tlmgr --verify-repo=none update --self

readarray -t packages < <(cut -d' ' -f2 "${depends}" | uniq)

tlmgr --verify-repo=none install "${packages[@]}"
tlmgr --verify-repo=none update "${packages[@]}"
