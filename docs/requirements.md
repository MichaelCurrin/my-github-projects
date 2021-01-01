# Requirements

| Name                 | Purpose                                                                      |
| -------------------- | ---------------------------------------------------------------------------- |
| GitHub account       | Repos owned by your account will used for reporting.                         |
| [GitHub dev token][] | For GraphQL API requests. Only _read_ access to your public repos is needed. |
| [Netlify][] account  | Optionally used to deploy the site remotely.                                 |
| [Ruby][] >= 2.6      | Run the custom Jekyll [plugins][] - includes a query to the GitHub API.      |
| [Bundler][]          | Install project-scoped gems from the [Gemfile][].                            |
| [Node][]             | Install and run project-scoped Node packages from the [package.json][].      |

This project will **not** work on GitHub Pages, unless you use GitHub Actions. Netlify is used here because it requires much less configuration than GitHub Actions.

[GitHub dev token]: https://github.com/settings/tokens
[Netlify]: https://netlify.com
[Ruby]: https://www.ruby-lang.org/en/
[Node]: https://nodejs.org/
[Bundler]: https://bundler.io/

[plugins]: https://github.com/MichaelCurrin/my-github-projects/tree/master/_plugins
[package.json]: https://github.com/MichaelCurrin/my-github-projects/blob/master/package.json
[Gemfile]: https://github.com/MichaelCurrin/my-github-projects/blob/master/Gemfile
