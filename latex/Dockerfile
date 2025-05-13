# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:latest
LABEL description = "RULTOR image for simple LaTeX projects"
LABEL version = "0.0.0"

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
ENV TL_URL=https://ftp.snt.utwente.nl/pub/software/tex/systems/texlive/tlnet
ENV PATH=${PATH}:/usr/local/texlive/${TL_YEAR}/bin/latest

RUN wget -q --no-check-certificate "${TL_URL}/install-tl.zip" \
  && unzip -qq install-tl.zip -d install-tl \
  && cd install-tl/install-tl-* \
  && perl ./install-tl --scheme=scheme-minimal --no-interaction "--repository=${TL_URL}" \
  && ln -s "$(ls "/usr/local/texlive/${TL_YEAR}/bin/")" "/usr/local/texlive/${TL_YEAR}/bin/latest" \
  && cd ~ && rm -rf install-tl* \
  && echo "export PATH=\${PATH}:/usr/local/texlive/${TL_YEAR}/bin/latest" >> "${HOME}/.profile" \
  && tlmgr init-usertree \
  && tlmgr option repository "${TL_URL}" \
  && tlmgr --verify-repo=none install texliveonfly collection-latex l3kernel l3packages latexmk l3build biber xetex \
  && chmod -R a+w /usr/local/texlive

RUN gem install texsc -v 0.8.0 \
  && gem install texqc -v 0.8.0

COPY latex/update-depends.sh /usr/bin
RUN sed -i -E "s|---URL---|${TL_URL}|g" /usr/bin/update-depends.sh
