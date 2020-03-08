# My Github Projects
> Portfolio of projects, built as a static site that groups Github repos by topic labels

[![Made with Jekyll](https://img.shields.io/badge/Made%20with-Jekyll-blue.svg)](https://jekyllrb.com)
[![Made with Ruby](https://img.shields.io/badge/Made%20with-Ruby-blue.svg)](https://www.ruby-lang.org)
[![Made with Github GQL](https://img.shields.io/badge/Made%20with-Github%20GraphQL-blue.svg)](https://developer.github.com/v4/)
[![GitHub tag](https://img.shields.io/github/tag/MichaelCurrin/my-github-projects.svg)](https://GitHub.com/MichaelCurrin/my-github-projects/tags/)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/MichaelCurrin/my-github-projects/blob/master/LICENSE)

- [Requirements](#requirements)
- [Reuse](#reuse)
- [Create a token](#create-a-token)
- [Remote setup](#remote-setup)
- [Local](#local)
    - [Install](#install)
    - [Run](#run)
- [Development](#development)
    - [Reloading](#reloading)
    - [Running scripts](#running-scripts)

## Requirements

- Github account
- Github API dev token
- Ruby >= 2.4
- Bundler

This project uses Jekyll 4 - see [Upgrading Jekyll](https://jekyllrb.com/docs/upgrading/3-to-4/).

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

1. Go to the [Personal access tokens](https://github.com/settings/tokens) page of your Github account. Or go through Settings then Developer Settings.
2. Create a token, with read access to your own repos.
3. Copy the token value.
    - This will be used in the remote and local build steps.
    - The value will not be visible after you leave this screen, however, you can always regenerate the token value.

## Remote setup

Netlify:

1. Ensure you have the repo or a fork in your Github account.
2. Add the site to Netlify.
3. Update build command.
4. Open the URL.

Github Pages:

Note that this does not build even with secret set, perhaps because it is not enabled on action or because the plugin is not considered safe.

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

Add your secret token value the repo's dotfile, which only needs one property in it

Example:

```sh
echo 'GITHUB_TOKEN=abcdef' > .env
```

### Run

```sh
$ make serve
```

Open in the browser:

- http://localhost:4000/

The Jekyll errors are not verbose, but this running with `--trace` command here.

```sh
$ make debug
```

## Development

### Access token

It could be possible to mark the token as optional and return empty data in the custom plugin, but this causes issues in other parts which except a structure.

One way to reduce build time is to comment out the Jekyll Github Metadata Plugin from the gem file or to set the number of repos in the GQL query file to a low number.

### Reloading

At build time:

- Github metadata - A request is done to Github API through the Jekyll Github Metadata plugin, which adds `site.github` to the templating namespace. This includes details about the owner, the current repo (based on the remote origin if local) and public repos.
- GraphQL request - A request is done to Github GraphQL API using this project's custom plugin.

When saving changes to the repo, the server will restart. The Github metadata will not be fetched again but any changes to changes to templating will be applied. The GraphQL request will also be done - investigation could be done to avoid this happening.

### Running scripts

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

### Github pages use

These might be needed or not help:

In plugin:

```ruby
    safe = true
```

If may not work at all still because of how Github Pages works.

Config:

```yaml
plugins:
 - faraday
 - jekyll-github-metadata
```
