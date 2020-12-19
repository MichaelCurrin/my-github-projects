# Background

This project was inspired by the listing of repository cards shown through [github/personal-website](https://github.com/github/personal-website) repo. That shows data for a couple of repos, using the [Jekyll GitHub Metadata plugin](https://github.com/jekyll/github-metadata) and GitHub REST API internally. The public repos output from the plugin covers repos in detail, but there is not topic data and the language labels are limited (they are inferred and they do not reflect the purpose or tooling of a project).

This _My GitHub Projects_ repo goes a step further by getting repos and their topics, then grouping them by their topics (labels set for a GitHub repo). This was made possible by create a plugin (in Ruby) and for efficiency this was done using the GitHub GraphQL API (such that one request returns 100 repos and their labels at once).

I did a proof-of-concept for a Ruby plugin for GraphQL request using this repo - [MichaelCurrin/github-gql-ruby](https://github.com/MichaelCurrin/github-gql-ruby). However, the two projects have diverged as I made more changes in this project than that one, until I can make that one installable or as a submodule + symlink into plugins directory. Also this portfolio site will be easier for me to maintain using a Ruby library for GraphQL or a Python script (which would write out a JSON file to be read as a data file by Jekyll).
I chose Ruby initially for interest so I could do something useful with Ruby but the solution is not so flexible for me.
