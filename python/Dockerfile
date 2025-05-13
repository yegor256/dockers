# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:0.0.1
LABEL description="RULTOR image for simple Python+Pip projects"
LABEL version="0.0.1"

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

# Python ftp: https://www.python.org/ftp/python
# Status of Python versions: https://devguide.python.org/versions/
ENV PYTHON_VERSION=3.13.3

RUN mkdir -p /root/.python-$PYTHON_VERSION
RUN wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz \
  && tar -xf Python-$PYTHON_VERSION.tgz \
  && cd Python-$PYTHON_VERSION \
  && ./configure --enable-optimizations --prefix=/root/.python-$PYTHON_VERSION \
  && make \
  && make altinstall \
  && echo "export PATH=\${PATH}:/.local/bin" >> "${HOME}/.profile" \
  && ln -s "/root/.python-${PYTHON_VERSION}/bin/python3.13" /usr/local/bin/python3 \
  && ln -s "/root/.python-${PYTHON_VERSION}/bin/pip3.13" /usr/local/bin/pip3 \
  && rm -rf "Python-${PYTHON_VERSION}.tgz" "Python-${PYTHON_VERSION}" \
  && python3 --version \
  && pip3 --version
