# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

.ONESHELL:
.PHONY: clean
.SHELLFLAGS := -e -o pipefail -c
SHELL := bash
LANGS=ruby java latex python
BUILDS=$(addsuffix .build,$(addprefix target/,$(LANGS)))
PUSHES=$(addsuffix .push,$(addprefix target/,$(LANGS)))
TESTS=$(addsuffix .test,$(addprefix target/,$(LANGS)))

all: $(PUSHES)

test: $(TESTS)

target/java.build: target/ruby.build
target/python.build: target/ruby.build
target/latex.build: target/ruby.build

target/%.push: target/%.build target/%.test | target
	b=$$(basename "$<")
	lang="$${b%.*}"
	docker push "yegor256/rultor-$${lang}"
	echo $? > "$@"

target/%.build: %/Dockerfile | target
	lang=$$(dirname "$<")
	docker build --file "$<" --platform=linux/x86_64 -t "yegor256/$${lang}" "$$(dirname "$<")"
	echo $? > "$@"

target/%.test: target/%.build
	b=$$(basename "$<")
	lang="$${b%.*}"
	img=yegor256/$${lang}
	docker run --rm "$${img}" pdd --version
	docker run --rm "$${img}" /bin/bash -c '
		set -ex
		useradd -m -G sudo r
		usermod -a -G nogroup r
		usermod -a -G ssh r
		usermod -a -G r r
		usermod -s /bin/bash r
		echo "%sudo ALL=(ALL) NOPASSWD:ALL"
		cp -R /root/.bashrc /root/.cache /root/.gemrc /root/.profile /home/r
		chown -R r:r /home/r
		su --login r --command "xcop --version"
	'

target:
	mkdir -p target

clean:
	rm -rf target
