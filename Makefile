# Make this avaiable in subprocesses after executing source command.
export GITHUB_TOKEN=''

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

debug:
	DEBUG=1 source .env && bundle exec jekyll build --trace
