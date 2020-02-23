---
title: All repos
layout: page
---

My public repos, sorted by name.

{% assign repos = site.github.public_repositories | filter: 'fork', false %}
{% for repo in repos %}
- {{ repo.owner.login }}/{{ repo.name }}
    >{{ repo.description }}
{% endfor %}
