# Development

Notes for developing this project.

- [Access token](#access-token)
- [Reloading](#reloading)
- [Running scripts](#running-scripts)
- [Github pages use](#github-pages-use)

## Access token

It could be possible to mark the token as optional and return empty data in the custom plugin, but this causes issues in other parts which except a structure.

One way to reduce build time is to comment out the Jekyll Github Metadata Plugin from the gem file or to set the number of repos in the GQL query file to a low number.

## Styling

[Bulma](https://bulma.io/) is used for CSS styling.

The [jekyll-octopod/jekyll-bulma](https://github.com/jekyll-octopod/jekyll-bulma) gem is used to make this easier if the Bulma version needs to be locked.


## Reloading

At build time:

- Github metadata - A request is done to Github API through the Jekyll Github Metadata plugin, which adds `site.github` to the templating namespace. This includes details about the owner, the current repo (based on the remote origin if local) and public repos.
- GraphQL request - A request is done to Github GraphQL API using this project's custom plugin.

When saving changes to the repo, the server will restart. The Github metadata will not be fetched again but any changes to changes to templating will be applied. The GraphQL request will also be done - investigation could be done to avoid this happening.

## Running scripts

The ruby script cannot be run directly, only through Jekyll. This seems to be a bug in one of the gems.

More specifically, after happens if `jekyll` is installed (it does install `eventmachine` in vendor but this can't pick it up.)

```
$ bundle exec ruby request.rb
Could not find eventmachine-1.2.7 in any of the sources
Run `bundle install` to install missing gems.
```

This does not help:

```ruby
gem 'eventmachine', '1.2.7'
```

## Github pages use

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
