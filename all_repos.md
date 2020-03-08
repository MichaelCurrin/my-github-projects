---
title: All repos
layout: page
---

My public repos, sorted by name. Using Github metadata plugin.

{% assign repos = site.github.public_repositories | filter: 'fork', false %}
{% for repo in repos %}
- {{ repo.owner.login }}/{{ repo.name }}
    > {{ repo.description }}
{% endfor %}

Using GQL:

{% for repo in site.data.all_repos %}
- {{ repo }}
{% endfor %}
