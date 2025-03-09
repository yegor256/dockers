#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

depends=$1

if [ ! -e "${depends}" ]; then
    echo "The file is absent: ${depends}"
    exit 1
fi

tlmgr option repository https://ftp.tu-chemnitz.de/pub/tug/historic/systems/texlive/2025/tlnet-final
tlmgr --verify-repo=none update --self

readarray -t packages < <(cut -d' ' -f2 "${depends}" | uniq)

tlmgr --verify-repo=none install "${packages[@]}"
tlmgr --verify-repo=none update "${packages[@]}"
