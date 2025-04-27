# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:latest
LABEL Description="RULTOR image for simple Rust projects" Version="0.0.0"

# Rust and Cargo
ENV PATH="${PATH}:${HOME}/.cargo/bin"
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y \
  && echo 'export PATH=${PATH}:${HOME}/.cargo/bin' >> /root/.profile \
  && ${HOME}/.cargo/bin/rustup toolchain install stable \
  && bash -c '"${HOME}/.cargo/bin/cargo" --version'
