#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

javac --version
mvn --version

[[ "$(javac --version)" =~ 17\.0 ]]

[[ "$(mvn --version)" =~ 3\.9\.6 ]]

[ -e /usr/bin/install-postgres.sh ]
