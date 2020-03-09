---
title: All Topics
layout: page
---

{% assign sorted_topics = site.data.all_topics | sort %}
{%- comment -%}
TODO background color.
header.
heading.
update instructions and bulma notes
background color of html to #333. See plugin docs
{%- endcomment -%}
<div id='repo-topics'>
{% for topic in sorted_topics %}
    <div>
        <a href="#{{ topic[0] }}"><h2 id="{{ topic[0] }}">&#35;{{ topic[0] }}</h2></a>

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
