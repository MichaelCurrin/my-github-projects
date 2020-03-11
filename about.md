---
title: Home
layout: page
---

Github repo: [{{ site.github.owner_name }}/{{ site.github.project_title }}]({{ site.github.owner_url }}/{{ site.github.project_title }})

[![Made with Jekyll](https://img.shields.io/badge/Made%20with-Jekyll-blue.svg)](https://jekyllrb.com)
[![Jekyll theme](https://img.shields.io/badge/Theme-jekyll%2D-bulma-blue.svg)](https://github.com/jekyll-octopod/jekyll-bulma)
[![Made with Ruby](https://img.shields.io/badge/Made%20with-Ruby-blue.svg)](https://www.ruby-lang.org)
[![Made with Github GQL](https://img.shields.io/badge/Made%20with-Github%20GraphQL-blue.svg)](https://developer.github.com/v4/)

### How it works

On build, a request is done to Github GraphQL API to get repos and their topic labels. For the All Topics page, the structure is inverted such that topics contain repos.
