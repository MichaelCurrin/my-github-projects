export GITHUB_TOKEN=''


help:
	@egrep '^\S|^$$' Makefile


install:
	bundle install --path vendor/bundle

upgrade:
	bundle update


s serve:
	source .env && bundle exec jekyll serve -l

debug:
	DEBUG=1 source .env && bundle exec jekyll build --trace
