---
title: All Topics
layout: page
---

{% assign sorted_topics = site.data.all_topics | sort %}

{% for topic in sorted_topics %}
### {{ topic[0] }}

{% assign repos = topic[1] %}
{% for repo in repos %}
- [{{ repo[0] }}]({{ repo[1].url }})
    * Description: {{ repo[1].description }}
    * Stars: {{ repo[1].stars }}
    * Forks: {{ repo[1].forks }}
    * Updated: {{ repo[1].updated_at | date_to_string }}
    * Created: {{ repo[1].created_at | date_to_string }}
{% endfor -%}
{% endfor %}
