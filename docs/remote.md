# Remote setup

## Netlify

1. Ensure you have the repo or a fork in your Github account.
2. Add the site to Netlify.
3. Add your _access key_ value to the deploy environment variables.
4. Open the URL.

Notes on the build command in [netlify.toml](/netlify.toml):

- The _Jekyll_ install is automatic, so just the JS install is needed.
- An `.env` file is not needed here, since using Netlify secrets.
- Netlify does not use _Bundler_.

Note that _Node_ is already available on Netlify.

## Github Pages

Note that this does **not build** to Github Pages, even with secret set. Perhaps because it is not enabled on action or because the plugin is not considered safe. Also the `npm` part has since been added which makes Github Pages harder still.
