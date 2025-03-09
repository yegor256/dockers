#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex

year=$1

# url=https://mirror.ctan.org/systems/texlive/tlnet/install-tl.zip
url=https://ftp.snt.utwente.nl/pub/software/tex/systems/texlive/tlnet

wget -q --no-check-certificate "${url}/install-tl.zip"
unzip -qq install-tl.zip -d install-tl
cd install-tl/install-tl-*
(
    echo 'selected_scheme scheme-minimal'
    echo 'option_doc 0'
    echo 'option_src 0'
    echo 'option_autobackup 0'
) > p
perl ./install-tl --profile=p "--repository=${url}"

ln -s "$(ls "/usr/local/texlive/${year}/bin/")" "/usr/local/texlive/${year}/bin/latest"
cd ~ && rm -rf install-tl*
echo "export PATH=\${PATH}:/usr/local/texlive/${year}/bin/latest" >> /root/.profile

tlmgr init-usertree
tlmgr option repository "${url}"
tlmgr --verify-repo=none install texliveonfly collection-latex l3kernel l3packages latexmk l3build biber xetex
chmod -R a+w /usr/local/texlive
