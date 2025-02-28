# SPDX-FileCopyrightText: Copyright (c) 2024 Yegor Bugayenko
# SPDX-License-Identifier: MIT

.ONESHELL:
.PHONY: clean
.SHELLFLAGS := -e -o pipefail -c
SHELL := bash
LANGS=ruby java latex python
BUILDS=$(addsuffix .build,$(addprefix target/,$(LANGS)))
PUSHES=$(addsuffix .push,$(addprefix target/,$(LANGS)))

all: $(PUSHES)

target/java.build: target/ruby.build
target/python.build: target/ruby.build
target/latex.build: target/ruby.build

target/%.push: target/%.build | target
	b=$$(basename "$<")
	lang="$${b%.*}"
	docker push "yegor256/rultor-$${lang}"
	echo $? > "$@"

target/%.build: %/Dockerfile | target
	lang=$$(dirname "$<")
	docker build --file "$<" --platform=linux/x86_64 -t "yegor256/$${lang}" "$$(dirname "$<")"
	echo $? > "$@"

target:
	mkdir -p target

clean:
	rm -rf target
