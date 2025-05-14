# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:0.0.1
LABEL description="RULTOR image for simple Python+Pip projects"
LABEL version="0.0.1"

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

RUN apt update \
  && apt install --yes --no-install-recommends python3 python3-pip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && echo "export PATH=\${PATH}:\${HOME}/.local/bin" >> "${HOME}/.profile" \
  && python3 --version \
  && pip3 --version
