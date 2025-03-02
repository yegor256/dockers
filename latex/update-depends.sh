#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

if [ ! -e DEPENDS.txt ]; then
    echo 'There is no DEPENDS.txt file in the current directory'
    exit 1
fi

tlmgr option repository ctan
tlmgr --verify-repo=none update --self

readarray -t packages < <(cut -d' ' -f2 DEPENDS.txt | uniq)

tlmgr --verify-repo=none install "${packages[@]}"
tlmgr --verify-repo=none update "${packages[@]}"
