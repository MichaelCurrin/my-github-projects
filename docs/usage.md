# Usage
> Run locally


## Serve

Start the development server.

```sh
$ make serve
```

Open in the browser:

- http://localhost:4000/


## Build

Do a build with verbose logging.

```sh
$ make build-dev
```


## Disable fetch

Run the build or serve steps without fetching GraphQL API data.

```sh
$ DISABLE_GQL=1 make build-dev
```

This will be quicker to run and doesn't require auth set up (an empty `.env` file is needed at least). The rendered site will just be mostly empty.


Note that the `github-metadata` plugin will still be used, to fetch user data like profile image. This doesn't require a token but will eventually get API rejects past the rate limiting threshold.
