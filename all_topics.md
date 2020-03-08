---
title: All Topics
layout: page
---

{% assign sorted_topics = site.data.all_topics | sort %}
{% for topic in sorted_topics %}
- {{ topic[0] }}
{% for repos in topic[1] %}
    * Name: {{ repos[0] }} Stars: {{ repos[1].stars }} Created: {{ repos[1].created_at }}
{% endfor -%}
{% endfor %}
