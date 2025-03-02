#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex

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
