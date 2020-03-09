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

<div id="repos" class="columns is-multiline is-mobile">
{% for repo_data in site.data.all_repos %}
    {% assign repo = repo_data[1] %}
    <div class="column is-3">
        {% include repo_card.html %}
    </div>
{% endfor %}
</div>
