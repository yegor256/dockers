#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

year=${TL_YEAR:-2026}
url=${TL_URL:-https://ftp.snt.utwente.nl/pub/software/tex/systems/texlive/tlnet}

apt-get --yes --fix-missing update
apt-get --yes --no-install-recommends install perl wget unzip
apt-get clean
rm -rf /var/lib/apt/lists/*

cd /tmp
wget -q --no-check-certificate "${url}/install-tl.zip"
unzip -qq install-tl.zip -d install-tl
cd install-tl/install-tl-*
perl ./install-tl --scheme=scheme-minimal --no-interaction "--repository=${url}"
ln -s "$(ls "/usr/local/texlive/${year}/bin/")" "/usr/local/texlive/${year}/bin/latest"
cd /tmp
rm -rf ./install-tl*

echo "export PATH=\${PATH}:/usr/local/texlive/${year}/bin/latest" > /etc/profile.d/texlive.sh
chmod +x /etc/profile.d/texlive.sh
export PATH="${PATH}:/usr/local/texlive/${year}/bin/latest"

tlmgr init-usertree
tlmgr option repository "${url}"
tlmgr --verify-repo=none install \
  texliveonfly collection-latex luaotfload l3kernel l3packages latexmk l3build biber xetex collection-fontsrecommended
tlmgr path add
chmod -R a+w /usr/local/texlive

pdflatex --version
