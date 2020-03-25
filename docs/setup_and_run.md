# Setup and run

- [Reuse](#reuse)
- [Create a token](#create-a-token)
- [Remote setup](#remote-setup)
    - [Netlify](#netlify)
    - [Github Pages](#github-pages)
- [Local](#local)
- [Install](#install)
    - [Install system dependencies](#install-system-dependencies)
    - [Install project dependencies](#install-project-dependencies)
    - [Setup access token](#setup-access-token)
- [Run](#run)
    - [Serve](#serve)
    - [Debug](#debug)


## Reuse

If you want to setup your own dev portfolio project like this:

1. Fork this repo to your own Github account.
3. Follow instructions in this doc for local or remote setup.
2. Optionally update badges in the docs to point to your repo.

You do not need to reconfigure any profile username detail to use this repo.

The only API configuration is a secret access token. If you create one for your own account, then the GraphQL query will return data for your own account, as the current authenticated user.

## Create a token

This project relies on setting a Github API access token either in the terminal or as a secret in Github Pages or Netlify. This token is then sent to Github API on the POST request data.

To set this up:

1. Go to the [Personal access tokens](https://github.com/settings/tokens) page of your Github account. Or go through Settings then Developer Settings.
2. Create a token, with read access to your own repos.
3. Copy the token value.
    - This will be used in the remote and local build steps.
    - The value will not be visible after you leave this screen, however, you can always regenerate the token value.


## Requirements

- **Ruby** >= `2.4`
- **Bundler**
- **NodeJS**


## Remote setup

### Netlify

1. Ensure you have the repo or a fork in your Github account.
2. Add the site to Netlify.
3. Update build command.
4. Add your access key value to the deploy environment variables.
5. Open the URL.

### Github Pages

Note that this does **not build** even with secret set, perhaps because it is not enabled on action or because the plugin is not considered safe.

1. Ensure you have this repo or a fork in your Github account repos as a public rep.
2. Edit repo Settings.
3. Enable Github Pages on `master` branch.
4. Open the URL.

## Install locally

### Install system dependencies

- Install Ruby and Bundler
    - Bundler should be installed as a _user_ gem.
    - See this [Jekyll setup guide](https://github.com/MichaelCurrin/static-sites-generator-resources/blob/master/Jekyll/setup_and_run.md) for help on install and to understand how these are used for Jekyll projects.
- Install Node
    - See this [Node guide](https://github.com/MichaelCurrin/learn-to-code/blob/master/Scripting%20languages/JavaScript/node.md) for help.


### Install project dependencies

Install **local gems**. This command will use _Bundler_ to install gems at project scope in the _vendor_ directory.

```sh
$ make install
```

### Setup access token

Add your secret **access token** value to the repo's dotfile, which only needs one property in it

Example:

```sh
echo 'GITHUB_TOKEN=abcdef' > .env
```

## Run locally

### Serve

Start the development server.

```sh
$ make serve
```

Open in the browser:

- http://localhost:4000/

### Debug

The Jekyll errors are not verbose, but this running with `--trace` command here. Note this will only build and not actually start the server.

```sh
$ make debug
```

If you want to disable fetching of GraphQL data, use this as a prefix before a command:

```sh
$ DISABLE_GQL=1 command
```
