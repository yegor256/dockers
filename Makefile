# SPDX-FileCopyrightText: Copyright (c) 2012-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

.ONESHELL:
.PHONY: all test build push clean ruby latex python rust java haskell
.SHELLFLAGS := -e -o pipefail -c
SHELL := bash
LANGS=ruby java latex python rust haskell
BUILDS=$(addsuffix .build,$(addprefix target/,$(LANGS)))
PUSHES=$(addsuffix .push,$(addprefix target/,$(LANGS)))
TESTS=$(addsuffix .test,$(addprefix target/,$(LANGS)))
EXTRAS=$(shell find extras/ -name '*.sh')
EXTRAS_STANDALONE=$(filter-out extras/install-maven.sh extras/install-gradle.sh,$(EXTRAS))
ETESTS=$(addsuffix .extra,$(addprefix target/,$(subst extras/,,$(subst .sh,,$(EXTRAS_STANDALONE)))))
PLATFORMS=linux/arm64,linux/amd64

VERSION=0.0.1

all: test

test: $(TESTS) $(ETESTS)

build: $(BUILDS)

push: test $(PUSHES)

ruby: target/ruby.test $(EXTRAS)
python: target/python.test
rust: target/rust.test
latex: target/latex.test
haskell: target/haskell.test
java: target/java.test
target/ruby.build: $(EXTRAS)
target/java.build: target/ruby.build
target/haskell.build: target/java.build
target/python.build: target/ruby.build target/java.build
target/rust.build: target/ruby.build
target/latex.build: target/ruby.build
target/java.push: | target/ruby.push
target/haskell.push: | target/java.push
target/python.push: | target/ruby.push target/java.push
target/rust.push: | target/ruby.push
target/latex.push: | target/ruby.push

pull: | target
	for lang in $(LANGS); do
		docker pull "yegor256/$${lang}"
	done

target/%.push: target/%.build target/%.test | target
	b=$$(basename "$<")
	lang="$${b%.*}"
	if [ -n "$(PLATFORMS)" ]; then
		docker buildx use multi-platform-builder 2>/dev/null \
			|| docker buildx create --use --name multi-platform-builder
		docker buildx build --progress=plain --file "$${lang}/Dockerfile" \
			"--platform=$(PLATFORMS)" \
			--tag "yegor256/$${lang}" \
			--tag "yegor256/$${lang}:$(VERSION)" --push .
	else
		docker tag "yegor256/$${lang}" "yegor256/$${lang}:$(VERSION)"
		docker push "yegor256/$${lang}"
		docker push "yegor256/$${lang}:$(VERSION)"
	fi
	echo $? > "$@"

target/%.build: %/Dockerfile $(EXTRAS) Makefile | target
	lang=$$(dirname "$<")
	docker buildx build --progress=plain --file "$<" \
		--tag "yegor256/$${lang}" \
		--tag "yegor256/$${lang}:$(VERSION)" --load .
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
		find /root \( -type f -o -type d -maxdepth 1 \) -exec cp -R {} /home/r \;
		chown -R r:r /home/r
		su --login r --command \"$$(cat tests/test-$${lang}.sh | sed 's|\"|\\\"|g')\"
	"
	echo $? > "$@"

target/%.extra: extras/%.sh target/ruby.build Makefile
	i=$$(basename "$<")
	if [ -n "$(PLATFORMS)" ]; then
		docker run --rm --platform=linux/amd64 yegor256/ruby "/usr/bin/$${i}"
	else
		docker run --rm yegor256/ruby "/usr/bin/$${i}"
	fi
	echo $? > "$@"

target:
	mkdir -p target

clean:
	rm -rf target
