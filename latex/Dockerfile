# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby
LABEL Description="RULTOR image for simple LaTeX projects" Version="0.0.0"

RUN apt-get -y -q update \
  && apt-get -y install --no-install-recommends \
    perl=* \
    inkscape=* \
    aspell=* \
    imagemagick=* \
    ghostscript=* \
    qpdf=* \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV TL_YEAR=2025
ENV PATH=${PATH}:/usr/local/texlive/${TL_YEAR}/bin/latest
COPY install-texlive.sh /tmp
RUN /tmp/install-texlive.sh "${TL_YEAR}"

RUN gem install texsc -v 0.8.0 \
  && gem install texqc -v 0.8.0

COPY update-depends.sh /usr/bin
