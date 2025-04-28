#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/postgresql-archive-keyring.gpg
echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
apt-get update --yes --fix-missing
apt-get install --yes libpq-dev
apt-get install --yes postgresql-client-16 postgresql-16
dir=$(realpath "/usr/lib/postgresql"/*)
version=$(basename "${dir}")
apt-get install --yes "postgresql-server-dev-${version}"
apt-get clean

for c in initdb postgres pg_ctl; do
    ln -s "$(realpath "${dir}/bin/${c}")" "/bin/${c}"
done

postgres --version
