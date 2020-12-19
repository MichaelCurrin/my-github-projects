# Requirements

| Name                                                   | Purpose                                                                              |
| ------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| GitHub account                                         | Repos in your account will be reported on.                                           |
| [GitHub dev token](https://github.com/settings/tokens) | For GraphQL API requests. Only _read_ access to your public repos is needed.         |
| [Netlify](https://netlify.com) account                 | Optionally used to deploy the site remotely.                                         |
| [Ruby](https://www.ruby-lang.org/en/) >= 2.4           | Run the custom Jekyll [plugins](/_plugins) - includes a query to the GitHub API.     |
| [Bundler](https://bundler.io/)                         | Install project-scoped gems from the [Gemfile](/Gemfile).                            |
| [Node](https://nodejs.org/)                            | Install and run project-scoped Node packages from the [package.json](/package.json). |

This project will **not** work on GitHub Pages, unless you use GitHub Actions. Netlify is used here because it requires much less configuration than GitHub Actions.
