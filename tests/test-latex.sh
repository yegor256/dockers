#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex

pdflatex --version
latexmk --version
bibtex --version

[[ "$(pdflatex --version)" =~ 2\.6 ]]
