# This makes the variable available in subprocesses, after executing source command.
# But also make sure not to overwrite a value set already, such as with Netlify secrets.
export GITHUB_TOKEN := $(if $(GITHUB_TOKEN), $(GITHUB_TOKEN), '')
JS_DIR = assets/js

default: install

h help:
	@egrep '^\S|^$$' Makefile


install-js:
	npm install

	rm -rf assets/*
	mkdir -p $(JS_DIR)
	cp node_modules/list.js/dist/* $(JS_DIR)

install-gems:
	bundle config set --local path vendor/bundle
	bundle install

upgrade-gems:
	bundle update

install: install-js install-gems


s serve:
	source .env && bundle exec jekyll serve --trace --livereload

pre-deploy: install build-prod

# Useful to preview the prod build and also log verbose messages and any errors.
build-dev:
	DEBUG=1 source .env && bundle exec jekyll build --trace

build-prod:	install-js
	JEKYLL_ENV=production bundle exec jekyll build --trace


# For debugging, check the value of the token.
# NB. Only run this on a remote if the logs are private, so no one steals your token on a PR preview. Will Netlify hide it? Do I need this? Move it to cheatsheet/recipe?
check-env:
	@echo Checking value of GITHUB_TOKEN...

	@echo "- Make-level with environment var: $$GITHUB_TOKEN"

	@echo "- Make-level with source:"
	@source .env && echo $$GITHUB_TOKEN

	@bash -c 'echo "- Subprocess-level: $$GITHUB_TOKEN"'
