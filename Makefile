SHELL = /bin/bash

# This makes the variable available in subprocesses, after executing source command.
# But also make sure not to overwrite a value set already, such as with Netlify secrets.
export GITHUB_TOKEN := $(if $(GITHUB_TOKEN), $(GITHUB_TOKEN), '')
JS_DIR = assets/js


default: install

# Local pre-deploy check.
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

upgrade:
	npm install list.js@latest
	bundle update
	git status --short

install: install-js setup-js install-gems

fmt:
	bundle exec rufo _plugins

s serve: fmt
	source .env && bundle exec jekyll serve --trace --livereload


build-dev:
	DEBUG=1 . .env && bundle exec jekyll build --trace

build-prod:
	JEKYLL_ENV=production bundle exec jekyll build --trace
