---
title: All repos
layout: page
---

This page shows all public Github repos owned by me.

<div id="repos" class="columns is-multiline">
{% for repo_data in site.data.all_repos %}
    {% assign repo = repo_data[1] %}
    <div class="column is-3-widescreen is-4-desktop is-6-tablet is-8-mobile">
        {% include repo_card.html %}
    </div>
{% endfor %}
</div>
