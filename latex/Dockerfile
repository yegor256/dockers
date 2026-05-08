# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:0.0.1
LABEL description="RULTOR image for simple LaTeX projects"
LABEL version="0.0.1"

WORKDIR /tmp

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

RUN apt-get -y -q update \
  && apt-get -y install --no-install-recommends \
    inkscape=* \
    aspell=* \
    imagemagick=* \
    ghostscript=* \
    qpdf=* \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV TL_YEAR=2026
ENV TL_URL=https://ftp.snt.utwente.nl/pub/software/tex/systems/texlive/tlnet
ENV PATH=${PATH}:/usr/local/texlive/${TL_YEAR}/bin/latest

RUN /usr/bin/install-latex.sh

RUN gem install texsc -v 0.8.0 \
  && gem install texqc -v 0.8.0

COPY latex/update-depends.sh /usr/bin
RUN sed -i -E "s|---URL---|${TL_URL}|g" /usr/bin/update-depends.sh
