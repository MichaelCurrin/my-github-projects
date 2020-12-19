## Installation
> How to setup the project locally


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


## Configure

1. Make sure you generated a token as per the [Token](token.md) doc.
2. Create an dotenv file from the template.
    ```sh
    $ cp .env.template .env
    ```
3. Open the `.env` file and add your secret token value and save the file.

The result will be something like:

- `.env`
    ```sh
    GITHUB_TOKEN=abcedf123
    ```

This project is setup top _ignore_ this file to prevent it being accidentally committed and shared.
