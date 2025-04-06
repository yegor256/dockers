# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:latest
LABEL Description="RULTOR image for simple Python+Pip projects" Version="0.0.0"

RUN wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz \
  && tar -xf Python-$PYTHON_VERSION.tgz \
  && cd Python-$PYTHON_VERSION \
  && ./configure --enable-optimizations \
  && make \
  && make altinstall
