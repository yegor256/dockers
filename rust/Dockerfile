# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:0.0.1
LABEL description="RULTOR image for simple Rust projects"
LABEL version="0.0.1"

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

ENV PATH=${PATH}:${HOME}/.cargo/bin

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y \
  && echo "export PATH=\${PATH}:\${HOME}/.cargo/bin" >> "${HOME}/.profile" \
  && rustup toolchain install stable
