# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

FROM yegor256/ruby:0.0.1
LABEL description="RULTOR image for simple Java+Maven projects"
LABEL version="0.0.1"

SHELL ["/bin/bash", "-e", "-c", "-o", "pipefail"]

ARG TARGETARCH
ENV MAVEN_OPTS=-Xmx1g
ENV JAVA_OPTS=-Xmx1g
ENV JAVA_VERSION=21
ENV MAVEN_VERSION=3.9.9
ENV GRADLE_VERSION=9.0.0

RUN /usr/bin/install-java.sh
ENV JAVA_HOME=/usr/lib/jvm/temurin-${JAVA_VERSION}-jdk-${TARGETARCH}

RUN /usr/bin/install-maven.sh
ENV M2_HOME=/usr/local/apache-maven/apache-maven-${MAVEN_VERSION}

RUN /usr/bin/install-gradle.sh
