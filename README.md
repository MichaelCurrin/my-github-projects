# My Github Projects
> Dev portfolio static site showing a user's Github repos grouped by topic

[![Netlify Status](https://api.netlify.com/api/v1/badges/43e6a441-a21b-4672-84be-e182a337e4cc/deploy-status)](https://app.netlify.com/sites/michael-currin/deploys)
[![GitHub tag](https://img.shields.io/github/tag/MichaelCurrin/my-github-projects.svg)](https://GitHub.com/MichaelCurrin/my-github-projects/tags/)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](#license)

**Static site dependencies:**

[![Made with Jekyll](https://img.shields.io/badge/Made_with-Jekyll-blue.svg?logo=jekyll)](https://jekyllrb.com)
[![Theme Jekyll Bulma](https://img.shields.io/badge/Theme-jekyll%2D-bulma-blue.svg)](https://github.com/jekyll-octopod/jekyll-bulma)
[![Made with Bulma](https://img.shields.io/badge/Made_with-Bulma-blue.svg?logo=bulma)](https://bulma.io/)
[![Made with Node.js](https://img.shields.io/badge/Made_with-Node.js-blue.svg?logo=javascript)](https://nodejs.org/)
[![Made with List.js](https://img.shields.io/badge/Made_with-List.js-blue.svg)](https://listjs.com/)

**API requests:**

[![Made with Ruby](https://img.shields.io/badge/Made_with-Ruby-blue.svg?logo=ruby)](https://www.ruby-lang.org)
[![Queries Github GraphQL API](https://img.shields.io/badge/Queries-Github_GraphQL_API-blue.svg?logo=graphql)](https://developer.github.com/v4/)

**Preview**

![sample screenshot](/sample.jpg)


**Table of contents:**

- [Purpose](#purpose)
- [Background](#background)
- [Requirements](#requirements)
- [Setup and run](#setup-and-run)
- [Development](#development)
- [Future development](#future-development)
- [License](#license)

This project will show your GitHub account's public repos as a statically generated Jekyll site, both locally or on a remote location such as on Netlify. (This _could_ work also with GitHub Actions to run the custom plugins and Jekyll 4. See the [Github Actions](https://jekyllrb.com/docs/continuous-integration/github-actions/) section on Jekyll docs - then a schedule parameter could be used for nightly or weekly builds.)

The main limitation that the site has rebuilt in order to get the latest repos and topic tags, but that is easy enough to trigger a new build by hand occasionally on Netlify - command-line `curl` POSTs requests can even trigger a build. And also this project works best when you have a lot of repos (over 10) and also use detailed but consistent tags based on the use (tool / linter / static site) or tech used (programming language / library / host location).


## Purpose

This project is setup to show repo data for the **current authenticated Github user** (i.e. not other users). This is easy with the `jekyll-github-metadata` plugin, but that uses Github API version 3 and it does not handle labels. So through some Ruby plugin scripts, this project fetches 100 repos including topics on each and then build a object with topic labels on the outside and repos within.

You can **fork** this project and setup as a Netlify static site which shows your **own** repos and their topic labels. You just have to configure your secret token and the query will get your repos.

When setup as a website, this project can serve the following purposes for the owner:

- Quick reference to **find your own repos** by name and check their stats. With future development, you can find most recent, most starred, etc.
- Group your repos by **topic**.
    - This is is very useful as a portfolio for **job interviews**, since someone can for example see how many Machine Learning, Python and static site projects you have. They can see at a glance what **activity** there is (last updated, how many stars) and optionally click through to see the actual repo.
    - This project is useful for maintaining or searching projects **for yourself**. For example if you want to find all your projects which are hosted on Github Pages or Netlify (assuming they are well-labelled). Or all the templates projects.
    - If you want to teach someone about a language or tool and what to show them what you've made, you can guide them to certain topics.
- This project gives you freedom to change the **styling** if you want to present the data in a different way.
- After future development, you can highlight repos or topics to **guide visitors towards**, or help you get to your most important or frequently accesses areas first.

If you want to explore your _private_ repos only, change the `privacy` value in the GraphQL query from `PUBLIC` to `PRIVATE`. Though you might want to just build that locally to avoid sharing that data.


## Background

This project was inspired by the listing of repository cards shown through [github/personal-website](https://github.com/github/personal-website) repo. That shows data for a couple of repos, using the [Jekyll Github Metadata plugin](https://github.com/jekyll/github-metadata) and Github REST API internally. The public repos output from the plugin covers repos in detail, but there is not topic data and the language labels are limited (they are inferred and they do not reflect the purpose or tooling of a project).

This _My Github Projects_ repo goes a step further by getting repos and their topics, then grouping them by their topics (labels set for a Github repo). This was made possible by create a plugin (in Ruby) and for efficiency this was done using the Github GraphQL API (such that one request returns 100 repos and their labels at once).

I did a POC for a Ruby plugin for GraphQL request using this repo - [MichaelCurrin/github-gql-ruby](https://github.com/MichaelCurrin/github-gql-ruby). However, the two projects have diverged as I made more changes in this project than that one, until I can make that one installable or as a submodule + symlink into plugins directory. Also this portfolio site will be easier for me to maintain using a Ruby library for GraphQL or a Python script (which would write out a JSON file to be read as a data file by Jekyll).
I chose Ruby initially for interest so I could do something useful with Ruby but the solution is not so flexible for me.

## Requirements

| Name                                                   | Purpose                                                                          |
| ------------------------------------------------------ | -------------------------------------------------------------------------------- |
| Github account                                         | Repos in this account will be reported on.                                       |
| [Github dev token](https://github.com/settings/tokens) | For GraphQL API requests. Only read access to your public repos is needed.       |
| [Netlify](https://netlify.com) account                 | Optionally setup the site remotely here.                                         |
| [Ruby](https://www.ruby-lang.org/en/) >= 2.4           | Run the custom Jekyll [plugins](/_plugins) - includes a query to the Github API. |
| [Bundler](https://bundler.io/)                         | Install project-scoped gems from [Gemfile](/Gemfile).                            |
| [Node](https://nodejs.org/)                            | Install and run project-scoped Node packages from [package.json](/package.json). |

The project gems include _Jekyll 4_, which is therefore not needed globally. For understanding differences between version 3 and 4, see [Upgrading Jekyll 3-to-4](https://jekyllrb.com/docs/upgrading/3-to-4/) on the _Jekyll_ website.


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


## Docs

- [Remote](/docs/remote.md) - Setup and run on Netlify.
- [Installation](/docs/installation.md) - Setup locally.
- [Usage](/docs/usage.md) - Run locally.
- [Development](/docs/development.md) docs.

## Future development

- [ ] Adding sorting of own repos by various fields.
- [ ] Add section to focus on chosen repos as a showcase.
- [ ] Add section to focus on chosen topics.
- [ ] Add images for topics.
- [ ] Show favorited repos, alone or by topic.
- [ ] Add paging to get more than 100 repos.
- [ ] Add GraphQL params on the payload for variables.
- [ ] Add use of language tag. See the original repo.


## Credits

- [mattgemmell/Liquid-Thousands-Separated-Filter](https://github.com/mattgemmell/Liquid-Thousands-Separated-Filter) 
    - Thanks to this repo for providing original code for [thousands-separated-filter.rb](/_plugins/thousands-separated-filter.rb).
- List.js
    - Add live filtering to repos based on user search input
    - Docs https://listjs.com
    - NPM https://www.npmjs.com/package/list.js

## License

Released under [MIT](/LICENSE).

Any significant portions of code used means you need to a copy of the original source in you repo.

Feel free to use this project for your own portfolio - as a fork or a new project. Please add a link back to this repo.
