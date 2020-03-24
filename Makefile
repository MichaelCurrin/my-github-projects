# This makes the variable available in subprocesses, after executing source command.
# But also make sure not to overwrite a value set already, such as with Netlify secrets.
export GITHUB_TOKEN := $(if $(GITHUB_TOKEN), $(GITHUB_TOKEN), '')

JS_DIR = assets/js


help:
	@egrep '^\S|^$$' Makefile


install-js:
	npm install

	rm -rf assets/*
	mkdir -p $(JS_DIR)
	cp node_modules/list.js/dist/* $(JS_DIR)

install-gems:
	bundle install --path vendor/bundle

upgrade-gems:
	bundle update

install: install-gems install-js


s serve:
	source .env && bundle exec jekyll serve -l

build-dev: install-js
	DEBUG=1 source .env && bundle exec jekyll build --trace


build-prod:	install-js
	jekyll build --trace
