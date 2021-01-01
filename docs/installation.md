## Installation
> How to setup the project locally


## Install system dependencies

- Ruby and Bundler - follow this [gist](https://gist.github.com/3af38fca4e2903cdedfb8402c18b2936).
- Install Node.js - follow this [gist](https://gist.github.com/MichaelCurrin/aa1fc56419a355972b96bce23f3bccba).


## Install project dependencies

Install local packages - NPM packages in `node_modules` and gems in `vendor`.

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
