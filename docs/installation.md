## Installation
> Setup locally

## Install system dependencies

- Install Ruby and Bundler
    - Bundler should be installed as a _user_ gem.
    - See this [Jekyll setup guide](https://github.com/MichaelCurrin/static-sites-generator-resources/blob/master/Jekyll/setup_and_run.md) for help on install and to understand how these are used for Jekyll projects.
- Install Node
    - See this [Node guide](https://github.com/MichaelCurrin/learn-to-code/blob/master/en/topics/scripting_languages/JavaScript/node.md) for help.


## Install project dependencies

Install **local gems**. This command will use _Bundler_ to install gems at project scope in the _vendor_ directory.

```sh
$ make install
```

## Setup access token

Add your secret **access token** value to the repo's dotfile, which only needs one property in it

Example:

```sh
echo 'GITHUB_TOKEN=abcdef' > .env
```
