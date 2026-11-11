#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

javac --version
mvn -ntp --version
env
gradle --version

mvn -ntp dependency:get -Dartifact=junit:junit:4.11

[[ "$(javac --version)" =~ 25\. ]]

[[ "$(mvn --version)" =~ 3\.10 ]]

[ -e /usr/bin/install-postgres.sh ]
