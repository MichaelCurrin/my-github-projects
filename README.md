# My Github Projects
> Portfolio of projects, built as a static site that groups Github repos by topic labels

[![Made with Jekyll](https://img.shields.io/badge/Made%20with-Jekyll-blue.svg)](https://jekyllrb.com)
[![Made with Ruby](https://img.shields.io/badge/Made%20with-Ruby-blue.svg)](https://www.ruby-lang.org)
[![Made with Github GQL](https://img.shields.io/badge/Made%20with-Github%20GraphQL-blue.svg)](https://developer.github.com/v4/)
[![GitHub tag](https://img.shields.io/github/tag/MichaelCurrin/my-github-projects.svg)](https://GitHub.com/MichaelCurrin/my-github-projects/tags/)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/MichaelCurrin/my-github-projects/blob/master/LICENSE)


## Requirements

- Github account
- Github API dev token
- Ruby >= 2.4
- Bundler

This project used Jekyll 4 - see [Upgrading Jekyll](https://jekyllrb.com/docs/upgrading/3-to-4/).

## Reuse

If you want to setup your own dev portfolio project like this:

1. Fork this repo to your own Github account.
3. Follow instructions in this doc for local or remote setup.
2. Optionally update badges in the docs to point to your repo.

You do not need to reconfigure any profile username detail to use this repo.

The only API configuration is a secret access token. If you create one for your own account, then the GraphQL query will return data for your own account, as the current authenticated user.

## Create a token

This project relies on setting a Github API access token either in the terminal or as a secret in Github Pages or Netlify. This token is then sent to Github API on the POST request data.

To set this up:

1. Go to Github Settings
2. Go to Developer tokens section.
3. Create a token with read access to your own repos.
4. Copy token value. This will not be visible after you leave this screen, however, you can always regenerate the token value.

## Remote setup

1. Ensure you have this repo or a fork in your Github account repos as a public rep.
2. Edit repo Settings.
3. Enable Github Pages on `master` branch.
4. Open the URL.

## Local

### Install

Install Ruby >= 2.4.

Install Bundler.

Install project dependencies.

```sh
$ make install
```

### Run

```sh
$ make serve
```

The Jekyll errors are not verbose, but this running with `--trace` command here.

```sh
$ make debug
```

## Development

### Notes

The ruby script cannot be run directly, only through Jekyll. This seems to be a bug in one of the gems.

More specifically, after happens if `jekyll` is installed (it does install `eventmachine` in vendor but this can't pick it up.)

```sh
$ bundle exec ruby request.rb
Could not find eventmachine-1.2.7 in any of the sources
Run `bundle install` to install missing gems.
```

This does not help:

```sh
$ gem 'eventmachine', '1.2.7'
```
