# The MIT License (MIT)
#
# Copyright (c) 2015 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM yegor256/rultor
MAINTAINER Yegor Bugayenko <yegor@teamed.io>
LABEL Description="Wo" Vendor="Yegor Bugayenko" Version="1.0"

RUN rm -rf ~/.ssh
RUN mkdir -p ~/.ssh
RUN echo -n "Host *\n\tStrictHostKeyChecking no" > ~/.ssh/config
RUN chmod 600 ~/.ssh/config

RUN apt-get update
RUN apt-get install -y phantomjs
RUN apt-get install -y texlive-latex-extra
RUN apt-get install -y xzdec
RUN tlmgr init-usertree
RUN tlmgr install helvetic
RUN tlmgr install psnfss

RUN gem install hoc
RUN apt-get install -y cloc
