# SPDX-FileCopyrightText: Copyright (c) 2012-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

.ONESHELL:
.PHONY: clean ruby latex python rust java
.SHELLFLAGS := -e -o pipefail -c
SHELL := bash
LANGS=ruby java latex python rust
BUILDS=$(addsuffix .build,$(addprefix target/,$(LANGS)))
PUSHES=$(addsuffix .push,$(addprefix target/,$(LANGS)))
TESTS=$(addsuffix .test,$(addprefix target/,$(LANGS)))
EXTRAS=$(shell find extras/ -name '*.sh')
TESTS=$(addsuffix .extra,$(addprefix target/,$(subst extras/,,$(subst .sh,,$(EXTRAS)))))
PLATFORMS=linux/x86_64,linux/arm64,linux/amd64

test: $(TESTS) $(ETESTS)

build: $(BUILDS)

push: $(PUSHES)

ruby: target/ruby.test $(EXTRAS)
python: target/python.test
rust: target/rust.test
latex: target/latex.test
java: target/java.test
target/ruby.build: $(EXTRAS)
target/java.build: target/ruby.build
target/python.build: target/ruby.build
target/rust.build: target/ruby.build
target/latex.build: target/ruby.build

target/%.push: target/%.build target/%.test | target
	b=$$(basename "$<")
	lang="$${b%.*}"
	ver=0.0.1
	docker tag "yegor256/$${lang}" "yegor256/$${lang}:$${ver}"
	docker push "yegor256/$${lang}"
	docker push "yegor256/$${lang}:$${ver}"
	echo $? > "$@"

target/%.build: %/Dockerfile $(EXTRAS) Makefile | target
	lang=$$(dirname "$<")
	docker buildx create --use --name multi-platform-builder
	docker buildx build --progress=plain --file "$<" \
		"$$( if [ -n "$(PLATFORMS)" ]; then echo "--platform=$(PLATFORMS)"; fi )" \
		--tag "yegor256/$${lang}" .
	echo $? > "$@"

target/%.test: target/%.build Makefile
	b=$$(basename "$<")
	lang="$${b%.*}"
	img=yegor256/$${lang}
	docker run --rm "$${img}" pdd --version
	docker run --rm "$${img}" /bin/bash -c "$$(cat tests/test-$${lang}.sh)"
	docker run --rm "$${img}" /bin/bash -c "
		useradd -m -G sudo r
		usermod -a -G nogroup r
		usermod -a -G ssh r
		usermod -a -G r r
		usermod -s /bin/bash r
		echo '%sudo ALL=(ALL) NOPASSWD:ALL'
		find /root \( -type f -o -type d -maxdepth 1 \) -exec cp -R {} /home/r \;
		chown -R r:r /home/r
		su --login r --command \"$$(cat tests/test-$${lang}.sh | sed 's|\"|\\\"|g')\"
	"
	echo $? > "$@"

target/%.extra: extras/%.sh target/ruby.build Makefile
	i=$$(basename "$<")
	docker run --rm \
		"$$( if [ -n "$(PLATFORMS)" ]; then echo '--platform=linux/amd64'; fi )" \
		yegor256/ruby "/usr/bin/$${i}"
	echo $? > "$@"

target:
	mkdir -p target

clean:
	rm -rf target
