---
title: All repos
layout: page
---

<div id="repos" class="columns is-multiline is-mobile">
{% for repo_data in site.data.all_repos %}
    {% assign repo = repo_data[1] %}
    <div class="column is-3">
        {% include repo_card.html %}
    </div>
{% endfor %}
</div>
