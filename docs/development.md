# Development

Notes for developing this project.

- [Background](#background)
- [Query](#query)
- [Access token](#access-token)
- [Styling](#styling)
    - [CSS file](#css-file)
- [Reloading](#reloading)
- [Running scripts](#running-scripts)
- [Format Ruby scripts](#format-ruby-scripts)
- [Packages](#packages)
    - [list.js](#listjs)
    - [jemoji](#jemoji)
    - [jekyll-timeago](#jekyll-timeago)
    - [jekyll-github-metadata](#jekyll-github-metadata)

## Background

This project was inspired by the listing of repository cards shown through [github/personal-website](https://github.com/github/personal-website) repo. That shows data for a couple of repos, using the [Jekyll GitHub Metadata plugin](https://github.com/jekyll/github-metadata) and GitHub REST API internally. The public repos output from the plugin covers repos in detail, but there is not topic data and the language labels are limited (they are inferred and they do not reflect the purpose or tooling of a project).

This _My GitHub Projects_ repo goes a step further by getting repos and their topics, then grouping them by their topics (labels set for a GitHub repo). This was made possible by create a plugin (in Ruby) and for efficiency this was done using the GitHub GraphQL API (such that one request returns 100 repos and their labels at once).

I did a proof-of-concept for a Ruby plugin for GraphQL request using this repo - [MichaelCurrin/github-gql-ruby](https://github.com/MichaelCurrin/github-gql-ruby). However, the two projects have diverged as I made more changes in this project than that one, until I can make that one installable or as a submodule + symlink into plugins directory. Also this portfolio site will be easier for me to maintain using a Ruby library for GraphQL or a Python script (which would write out a JSON file to be read as a data file by Jekyll).
I chose Ruby initially for interest so I could do something useful with Ruby but the solution is not so flexible for me.

# Future development ideas

- [ ] Adding sorting of own repos by various fields.
- [ ] Add section to focus on chosen repos as a showcase.
- [ ] Add section to focus on chosen topics.
- [ ] Add images for topics.
- [ ] Show favorited repos, alone or by topic.
- [ ] Add paging to get more than 100 repos.
- [ ] Add GraphQL params on the payload for variables.
- [ ] Add use of language tag. See the original repo.


## Query

I can't exclude archived repos in the query. There is a `isLocked` filter but this gives no results even though I have to archived repos.

I can still use `isArchived` as a field on a repo.

Both `pushedAt` and `updatedAt` give the same value I think for a push. But the `pushedAt` one doesn't count updating the repo setup on GitHub, meaning `updatedAt` will be more recent so I use that.


## Access token

It could be possible to mark the token as _optional_ and return empty data in the custom plugin, but this causes issues in other parts which except a structure.

One way to reduce build time is to comment out the Jekyll GitHub Metadata Plugin from the gem file or to set the number of repos in the GQL query file to a low number.

To avoid your token being exposed in a PR build triggered by a malicious fork (which might add to the build command or `Makefile`, please keep your log visibility as **private** in your Netlify app's Deploy settings.


## Styling

The [jekyll-octopod/jekyll-bulma](https://github.com/jekyll-octopod/jekyll-bulma) gem is used. This makes it easy to start using existing templating approach based on [Bulma](https://bulma.io/) component styling. It also means Bulma is instead and locked at a version, which was the main reason for using the theme here.

Bulma links:

- [Form controls](https://bulma.io/documentation/form/general/)
- [Panel](https://bulma.io/documentation/components/panel/) doc - for search bar.


### CSS file

See the [SASS][] directory.

[SASS]: https://github.com/MichaelCurrin/my-github-projects/tree/master/_sass

This file shadows the name of an empty file in the theme, to ensure it gets processed. There may be
better ways but this works okay. This content is added to the main.css file created mostly from
Bulma content.

This is not ideal as it does not replace the existing rule (such as background color), but it does
appends at the bottom of the main.css, which still works. Maybe this could be split out further
using multiple files, variables and imports, but this works okay.

Maybe override in utilities/derived-variables. Or over variables before import is done, where color variables are used.


## Reloading

At build time:

- GitHub metadata - A request is done to GitHub API through the Jekyll GitHub Metadata plugin, which adds `site.github` to the templating namespace. This includes details about the owner, the current repo (based on the remote origin if local) and public repos.
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

Update: Maybe adding eventmachine to Gemfile and bundle install would then help?


## Format Ruby scripts

```sh
$ make fmt
```


## Packages

### list.js

Add live filtering to repos based on user search input.

- Docs - https://listjs.com
- NPM - https://www.npmjs.com/package/list.js


### jemoji

- https://github.com/jekyll/jemoji

This adds support for emojis. This helps for processing emojis in descriptions. Unfortunately, while it processes something like `:shield:` it does not process others like `:badger:`. See the Badge Generator repo.

### jekyll-timeago

- https://github.com/markets/jekyll-timeago

Adds support for showing a date as how long ago (e.g. `today` or `2 months and 2 days ago`). A downside of this is that `today` is relative to the build date and not the date for the viewer visiting the site, so this should go back to plain dates, or the site should rebuild more often.

### jekyll-github-metadata

Take this out locally to avoid API rate limit warnings. You just won't get user profile data of the user, such as the logo.
