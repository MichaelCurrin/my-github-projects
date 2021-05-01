SHELL = /bin/bash
JS_DIR = assets/js
export GITHUB_TOKEN

default: install

all: install build-dev

h help:
	@egrep '^[a-z -]+:' Makefile


.PHONY: hooks
hooks:
	cd .git/hooks && ln -s -f ../../hooks/pre-push pre-push

install-js:
	npm install

setup-js:
	rm -rf assets/*
	mkdir -p $(JS_DIR)
	cp node_modules/list.js/dist/* $(JS_DIR)

install-gems:
	bundle config set --local path vendor/bundle
	bundle install

install: install-js setup-js install-gems

upgrade:
	npm install list.js@latest

	bundle clean
	bundle update

	git status --short


fmt:
	bundle exec rufo _plugins


s serve: fmt
	source .env \
		&& bundle exec jekyll serve --trace --livereload


build-dev:
	DEBUG=1 source .env \
		&& bundle exec jekyll build --trace

build-prod:
	JEKYLL_ENV=production bundle exec jekyll build --trace
