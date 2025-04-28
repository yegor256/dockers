# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:latest
LABEL Description="RULTOR image for simple Python+Pip projects" Version="0.0.0"

RUN apt-get update -y --fix-missing \
  && apt-get -y install libpq-dev libssl-dev openssl libffi-dev python3 python3-pip python3-dev \
  && rm -f /usr/lib/python3.*/EXTERNALLY-MANAGED \
  && ln -s $(which python3) /usr/bin/python \
  && pip3 install -Iv --upgrade pip \
  && apt-get clean
