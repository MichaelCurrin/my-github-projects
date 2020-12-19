# This makes the variable available in subprocesses, after executing source command.
# But also make sure not to overwrite a value set already, such as with Netlify secrets.
export GITHUB_TOKEN := $(if $(GITHUB_TOKEN), $(GITHUB_TOKEN), '')
JS_DIR = assets/js


default: install

# Local pre-deploy check.
all: install build-dev


h help:
	@egrep '^[a-z -]+:' Makefile


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
	npm install list.js
	bundle update

install: install-js setup-js install-gems


s serve:
	source .env && bundle exec jekyll serve --trace --livereload


# Preview the prod build with verbose log.
build-dev:
	DEBUG=1 source .env && bundle exec jekyll build --trace

build-prod:
	JEKYLL_ENV=production bundle exec jekyll build --trace
