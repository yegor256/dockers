#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

javac --version
mvn --version
env
gradle --version

mvn dependency:get -Dartifact=junit:junit:4.11

[[ "$(javac --version)" =~ 21\.0 ]]

[[ "$(mvn --version)" =~ 3\.9 ]]

[ -e /usr/bin/install-postgres.sh ]
