---
title: All Topics
layout: page
---

{% assign sorted_topics = site.data.all_topics | sort %}
<div id='repo-topics'>
{% for topic in sorted_topics %}
    <div>
        <a href="#topic-{{ topic[0] }}"><h2 id="topic-{{ topic[0] }}">&#35;{{ topic[0] }}</h2></a>

        {% assign repos = topic[1] %}
        <div class="columns is-multiline is-mobile">
            {% for repo_data in repos %}
                {% assign repo = repo_data[1] %}
                <div class="column is-one-third">
                    {% include repo_card.html %}
                </div>
            {% endfor -%}
        </div>

        <br>
    </div>
{% endfor %}
</div>
