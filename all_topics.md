---
title: All Topics
layout: page
---

{% assign sorted_topics = site.data.all_topics | sort %}

{% for topic in sorted_topics %}
### {{ topic[0] }}

{% assign repos = topic[1] %}
{% for repo in repos %}
* Name: {{ repo[0] }} Stars: {{ repo[1].stars }} Created: {{ repo[1].created_at }}
{% endfor -%}
{% endfor %}
