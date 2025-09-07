#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

pdflatex --version
latexmk --version
bibtex --version
biber --version
l3build --version
gs --version
qpdf --version
texsc --version
texqc --version
inkscape --version

[[ "$(pdflatex --version)" =~ 2\.6 ]]

tlmgr install iexec

echo "hard ffcode" > /tmp/DEPENDS.txt
update-depends.sh /tmp/DEPENDS.txt
