# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/java:0.0.1
LABEL description="RULTOR image for simple Haskell+Java projects"
LABEL version="0.0.1"

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

RUN gpg --batch --recv-keys ECA44F5A172EDAD947F39E3D4275CDA6A29BED43 \
  && case "$(uname -m)" in \
       x86_64) GHCUP_ARCH=x86_64 ;; \
       aarch64|arm64) GHCUP_ARCH=aarch64 ;; \
       *) echo "unsupported architecture: $(uname -m)" && exit 1 ;; \
     esac \
  && curl "https://downloads.haskell.org/~ghcup/${GHCUP_ARCH}-linux-ghcup" > /usr/bin/ghcup \
  && chmod +x /usr/bin/ghcup \
  && ghcup config set gpg-setting GPGStrict

ARG GHC=9.6.7
ARG CABAL=3.12.1.0

RUN ghcup -v install ghc --isolate /usr/local --force "${GHC}" \
  && ghcup -v install cabal --isolate /usr/local/bin --force "${CABAL}" \
  && cabal update \
  && ghc --version \
  && cabal --version
