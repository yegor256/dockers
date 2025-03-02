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
    cmake=* libssl-dev=* libjpeg-dev* \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV TEXLIVE_YEAR=2024
ENV PATH=${PATH}:/usr/local/texlive/${TEXLIVE_YEAR}/bin/latest
# hadolint ignore=DL3003
RUN wget -q --no-check-certificate http://mirror.ctan.org/systems/texlive/tlnet/install-tl.zip \
  && unzip -qq install-tl.zip -d install-tl \
  && cd install-tl/install-tl-* \
  && echo "selected_scheme scheme-minimal" > p \
  && perl ./install-tl --profile=p \
  && ln -s "$(ls /usr/local/texlive/${TEXLIVE_YEAR}/bin/)" "/usr/local/texlive/${TEXLIVE_YEAR}/bin/latest" \
  && cd ~ && rm -rf install-tl* \
  && echo "export PATH=\${PATH}:/usr/local/texlive/${TEXLIVE_YEAR}/bin/latest" >> /root/.profile \
  && tlmgr init-usertree \
  && tlmgr option repository ctan \
  && tlmgr --verify-repo=none update --self \
  && tlmgr install texliveonfly collection-latex l3kernel l3packages latexmk l3build biber xetex

RUN git clone https://github.com/qpdf/qpdf \
  && cd qpdf \
  && git checkout v11.10.1 \
  && cmake -S . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  && cmake --build build \
  && cmake --install "$(pwd)/build" \
  && cd - \
  && rm -rf qpdf \
  && export LD_LIBRARY_PATH=/usr/local/lib \
  && ldconfig

RUN gem install texsc -v 0.8.0 \
  && gem install texqc -v 0.8.0

COPY update-depends.sh /usr/bin
