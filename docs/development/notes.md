# Development

Notes for developing this project.

- [Query](#query)
- [Access token](#access-token)
- [Styling](#styling)
    - [CSS file](#css-file)
- [Reloading](#reloading)
- [Running scripts](#running-scripts)
- [Format Ruby scripts](#format-ruby-scripts)


## Query

I can't exclude archived repos in the query. There is a `isLocked` filter but this gives no results even though I have to archived repos.

I can still use `isArchived` as a field on a repo.


## Access token

It could be possible to mark the token as _optional_ and return empty data in the custom plugin, but this causes issues in other parts which except a structure.

One way to reduce build time is to comment out the Jekyll GitHub Metadata Plugin from the gem file or to set the number of repos in the GQL query file to a low number.

To avoid your token being exposed in a PR build triggered by a malicious fork (which might add to the build command or `Makefile`, please keep your log visiblity as **private** in your Netlify app's Deploy settings.


## Styling

The [jekyll-octopod/jekyll-bulma](https://github.com/jekyll-octopod/jekyll-bulma) gem is used. This makes it easy to start using existing templating approach based on [Bulma](https://bulma.io/) component styling. It also means Bulma is instead and locked at a version, which was the main reason for using the theme here.

Bulma links:

- [Form controls](https://bulma.io/documentation/form/general/)
- [Panel](https://bulma.io/documentation/components/panel/) doc - for search bar.


### CSS file

See the [\_scss](/_sass/) directory.

This file shadows the name of an empty file in the theme, to ensure it gets processed. There
may be better ways but this works okay. This content is added to the main.css file created mostly
from Bulma content.

This is not ideal as it does not replace the existing rule (such as background color),
but it does appends at the bottom of the main.css, which still works. Maybe this could be split
out further using multiple files, variables and imports, but this works okay.

Maybe override in utilities/derived-variables. Or over variables before import is done, where color variables are used.


## Reloading

At build time:

- GithHub metadata - A request is done to GitHub API through the Jekyll GitHub Metadata plugin, which adds `site.github` to the templating namespace. This includes details about the owner, the current repo (based on the remote origin if local) and public repos.
- GraphQL request - A request is done to GitHub GraphQL API using this project's custom plugin.

When saving changes to the repo, the server will restart. The GitHub metadata will not be fetched again but any changes to changes to templating will be applied. The GraphQL request will also be done - investigation could be done to avoid this happening.


## Running scripts

The Ruby plugin script cannot be run directly, only through Jekyll. This seems to be a bug in one of the gems.

More specifically, it happens after `jekyll` is installed (it does install `eventmachine` in vendor but this can't pick it up).

```sh
$ bundle exec ruby request.rb
```
```
Could not find eventmachine-1.2.7 in any of the sources
Run `bundle install` to install missing gems.
```

This does not help:

```ruby
gem 'eventmachine', '1.2.7'
```

Update: Maybe adding eventmachine to Gemfile and bundle install would then hlpe?


## Format Ruby scripts

Requires `rufo` to be installed globally.

```sh
$ make format
```
