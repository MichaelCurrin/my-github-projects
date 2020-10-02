---
title: Repos
layout: page
---

This page shows all public GitHub repos which are owned by me.


<div id="repos">
    <div class="container">
        <!-- Filter controls -->
        <div class="field">
            <p class="control has-icons-left">
                <input class="search input" type="text" placeholder="Search repo names">
                <span class="icon is-left">
                    <i class="fas fa-search" aria-hidden="true"></i>
                </span>
            </p>
        </div>
    </div>

    <br>
    <br>

    <div class="container">
        <div id="repo-cards" class="columns is-multiline list">
            {% for repo_data in site.data.all_repos %}
                {% assign repo = repo_data[1] %}
                <div class="column is-3-widescreen is-4-desktop is-6-tablet is-8-mobile">
                    {% include repo_card.html %}
                </div>
            {% endfor %}
        </div>
    </div>

</div>

<script>
        var options = {
            valueNames: [
                {
                    name: 'list-name',
                    attr: 'data-name'
                }
            ]
        };
        var userList = new List('repos', options);

</script>
