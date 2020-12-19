# Remote setup


## Create a token

Follow the [Token](token.md) doc then continue below.


## Setup Netlify

1. Ensure you have the repo or a fork in your GitHub account.
2. Add the repo to your Netlify account.
3. Edit the deploy **environment** variables - add `GITHUB_TOKEN` and use your value.
4. Open the deployed URL.

Notes on the build command in [netlify.toml](/netlify.toml):

- The _Jekyll_ install is automatic, so just the JS install is needed.
- An `.env` file is not needed here, since using Netlify secrets.
- Netlify does not use _Bundler_.

Note that _Node_ is already available on Netlify.


## Setup GitHub Pages

Note that this does **not build** to GitHub Pages.

You need to add a GitHub Actions workflow instead, which handles install and run steps and use of the token.
