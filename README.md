# My Github Projects
> Dev portfolio static site showing a user's Github repos grouped by topic

[![Netlify Status](https://api.netlify.com/api/v1/badges/43e6a441-a21b-4672-84be-e182a337e4cc/deploy-status)](https://app.netlify.com/sites/michael-currin/deploys)
[![Made with Jekyll](https://img.shields.io/badge/Made%20with-Jekyll-blue.svg)](https://jekyllrb.com)
[![Jekyll theme](https://img.shields.io/badge/Theme-jekyll%2D-bulma-blue.svg)](https://github.com/jekyll-octopod/jekyll-bulma)
[![Made with Ruby](https://img.shields.io/badge/Made%20with-Ruby-blue.svg)](https://www.ruby-lang.org)
[![Made with Github GQL](https://img.shields.io/badge/Made%20with-Github%20GraphQL-blue.svg)](https://developer.github.com/v4/)
[![Made with Github GQL](https://img.shields.io/badge/Made%20with-List.js-blue.svg)](https://listjs.com/)
[![GitHub tag](https://img.shields.io/github/tag/MichaelCurrin/my-github-projects.svg)](https://GitHub.com/MichaelCurrin/my-github-projects/tags/)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](#license)

- [Purpose](#purpose)
- [Background](#background)
- [Requirements](#requirements)
- [Setup and run](#setup-and-run)
- [Development](#development)
- [Future development](#future-development)
- [License](#license)

This project will show your Github account's public repos as a statically generated Jekyll site, both locally or on a remote location such as on Netlify.

The main limitation that it has rebuilt in order to get the latest repos and topic tags though, but it is easy enough to trigger a new build by hand occasionally on Netlify. And also this project works best when you have a lot of repos (over 10) and also use detailed but consistent tags based on the use (tool / linter / static site) or tech used (programming language / library / host location).

## Purpose

This project is setup to show repo data for the **current authenticated user** (i.e. not other users).

You can fork this project and setup as a Netlify static site which shows your **own** repos and their topic labels.

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

This project was inspired by the listing of repository cards shown through [github/personal-website](https://github.com/github/personal-website) repo. That shows data for a couple of repos, using the Jekyll Github Metadata plugin and Github REST API internally. The public repos output from the plugin covers repos in detail, but there is not topic data and the language labels are limited (they are inferred and they do not reflect the purpose or tooling of a project).

This _My Github Projects_ repo goes a step further by getting repos and their topics, then grouping them by their topics (labels set for a Github repo). This was made possible by create a plugin (in Ruby) and for efficiency this was done using the Github GraphQL API (such that one request returns 100 repos and their labels at once).

## Requirements

| Name                                                   | Description                                                                                           |
| ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| Github account                                         | Your repos stored there will be referenced.                                                           |
| [Github dev token](https://github.com/settings/tokens) | For V4 GraphQL API requests.                                                                          |
| [Netlify](https://netlify.com) account                 | If you want to setup the site remotely and not just locally.                                          |
| [Ruby](https://www.ruby-lang.org/en/) >= 2.4           | For the custom Jekyll plugins in [\_plugins](/_plugins) directory, including querying the Github API. |
| [Bundler](https://bundler.io/)                         | Used to install project-scoped gems from [Gemfile](/Gemfile).                                         |

The project gems include _Jekyll 4_, which is therefore not needed globally. For understanding differences between version 3 and 4, see [Upgrading Jekyll 3-to-4](https://jekyllrb.com/docs/upgrading/3-to-4/) on the _Jekyll_ website.

## Setup and run

See [setup and run](/docs/setup_and_run.md) doc.

## Development

See [development](/docs/development.md) docs.

## Future development

- [ ] Adding sorting of own repos by various fields.
- [ ] Add section to focus on chosen repos as a showcase.
- [ ] Add section to focus on chosen topics.
- [ ] Add images for topics.
- [ ] Show favorited repos, alone or by topic.
- [ ] Add paging to get more than 100 repos.
- [ ] Add GraphQL params on the payload for variables.
- [ ] Add use of language tag. See the original repo.

## License

See [LICENSE](/LICENSE).

Feel free to use this project for your own portfolio but please give credit in the repo and the website itself to this repo.
