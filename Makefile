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

test: $(TESTS)

push: $(PUSHES)

ruby: target/java.test
python: target/python.test
latex: target/latex.test
java: target/java.test
target/java.build: target/ruby.build
target/python.build: target/ruby.build
target/latex.build: target/ruby.build

target/%.push: target/%.build target/%.test | target
	b=$$(basename "$<")
	lang="$${b%.*}"
	ver=0.0.1
	docker tag "yegor256/$${lang}" "yegor256/$${lang}:$${ver}"
	docker push "yegor256/$${lang}"
	docker push "yegor256/$${lang}:$${ver}"
	echo $? > "$@"

target/%.build: %/Dockerfile | target
	lang=$$(dirname "$<")
	docker build --progress=plain --file "$<" \
		--platform=linux/x86_64,linux/arm64,linux/amd64 \
		--tag "yegor256/$${lang}" "$$(dirname "$<")"
	echo $? > "$@"

target/%.test: target/%.build tests/test-%.sh Makefile
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
		cp -R /root/.bashrc /root/.cache /root/.gemrc /root/.profile /home/r
		chown -R r:r /home/r
		su --login r --command \"$$(cat tests/test-$${lang}.sh | sed 's|\"|\\\"|g')\"
	"
	echo $? > "$@"

target:
	mkdir -p target

clean:
	rm -rf target
