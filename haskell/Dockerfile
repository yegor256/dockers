# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/java:0.0.1
LABEL description="RULTOR image for simple Haskell+Java projects"
LABEL version="0.0.1"

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

ARG GHC=8.10.7
ARG CABAL=latest

RUN gpg --batch --keyserver keys.openpgp.org --recv-keys ECA44F5A172EDAD947F39E3D4275CDA6A29BED43 \
  && curl https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup > /usr/bin/ghcup \
  && chmod +x /usr/bin/ghcup

RUN ghcup config set gpg-setting GPGStrict \
  && ghcup -v install ghc --isolate /usr/local --force "${GHC}" \
  && ghcup -v install cabal --isolate /usr/local/bin --force "${CABAL}" \
  && cabal update \
  && cabal --version
