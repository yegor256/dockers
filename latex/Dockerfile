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

ENV TL_YEAR=2024
ENV PATH=${PATH}:/usr/local/texlive/${TL_YEAR}/bin/latest
# hadolint ignore=DL3003
RUN wget -q --no-check-certificate http://mirror.ctan.org/systems/texlive/tlnet/install-tl.zip \
  && unzip -qq install-tl.zip -d install-tl \
  && cd install-tl/install-tl-* \
  && echo "selected_scheme scheme-minimal" > p \
  && perl ./install-tl --profile=p \
  && update-tlmgr-latest.sh --update \
  && ln -s "$(ls /usr/local/texlive/${TL_YEAR}/bin/)" "/usr/local/texlive/${TL_YEAR}/bin/latest" \
  && cd ~ && rm -rf install-tl* \
  && echo "export PATH=\${PATH}:/usr/local/texlive/${TL_YEAR}/bin/latest" >> /root/.profile \
  && tlmgr init-usertree \
  && tlmgr option repository ctan \
  && tlmgr --verify-repo=none update --self \
  && tlmgr install texliveonfly collection-latex l3kernel l3packages latexmk l3build biber xetex \
  && chmod -R a+w /usr/local/texlive \
  && update-tlmgr-latest.sh --update

RUN gem install texsc -v 0.8.0 \
  && gem install texqc -v 0.8.0

COPY update-depends.sh /usr/bin
